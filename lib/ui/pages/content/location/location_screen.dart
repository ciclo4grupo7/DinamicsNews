// ignore_for_file: avoid_print, prefer_const_constructors, prefer_is_empty

//import 'dart:developer';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamics_news/data/repositories/firestore_database.dart';
//import 'package:dynamics_news/domain/use_cases/controllers/location2.dart';
import 'package:flutter/material.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/data/services/location.dart';
import 'package:dynamics_news/domain/models/location.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/controllers/connectivity.dart';
import 'package:dynamics_news/domain/use_cases/controllers/location.dart';
import 'package:dynamics_news/domain/use_cases/controllers/permissions.dart';
import 'package:dynamics_news/domain/use_cases/controllers/ui.dart';
import 'package:dynamics_news/domain/use_cases/location_management.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widgets/location_card.dart';

class LocationScreen extends StatelessWidget {
  // News empty constructor
  LocationScreen({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>();
  final permissionsController = Get.find<PermissionsController>();
  final connectivityController = Get.find<ConnectivityController>();
  final uiController = Get.find<UIController>();
  final locationController = Get.find<LocationController>();
  final service = LocationService();

  @override
  Widget build(BuildContext context) {
    final _uid = authController.currentUser!.uid;
    final _name = authController.currentUser!.displayName ?? authController.currentUser!.email!.split('@')[0] ;
    _init(_uid, _name);
    //Controllerlocations controlubicacion = Get.find();
    //FirestoreDatabase controlp = Get.find();
    final controlp = FirestoreDatabase();
    
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => locationController.location != null
                ? LocationCard(
                    key: const Key("myLocationCard"),
                    title: 'MI UBICACIÓN',
                    lat: locationController.location!.lat,
                    long: locationController.location!.long,
                    onUpdate: () {
                      if (permissionsController.locationGranted &&
                          connectivityController.connected) {
                        _updatePosition(_uid, _name);

                        var ubicacion = <String, dynamic>{
                          'lat': locationController.location!.lat,
                          'lo': locationController.location!.long,
                          'name': _name,
                          'uid': _uid,
                        };
                        controlp.guardarubicacion(ubicacion, _uid);
                      }
                    },
                  )
                : const CircularProgressIndicator(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'CERCA DE MÍ',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          // ListView on remaining screen space
          Obx(() => (locationController.location != null)
          ? getInfo(context, controlp.readLocations(), _uid,
                    locationController.location!.lat.toString(), locationController.location!.long.toString())
          : Center(child: Icon(Icons.account_box_sharp))),
        ],
      ),
    );
  }

  _init(String uid, String name) {
    if (!permissionsController.locationGranted) {
      permissionsController.manager.requestGpsPermission().then((granted) {
        if (granted) {
          locationController.locationManager = LocationManager();
          _updatePosition(uid, name);
        } else {
          uiController.screenIndex = 0;
        }
      });
    } else {
      locationController.locationManager = LocationManager();
      _updatePosition(uid, name);
    }
  }

  _updatePosition(String uid, String name) async {
    final position = await locationController.manager.getCurrentLocation();
    locationController.location = MyLocation(
        name: name, id: uid, lat: position.latitude, long: position.longitude);
  }
}


@override
Widget getInfo(BuildContext context, Stream<QuerySnapshot> ct, String uid,
    String lat, String lo) {
  return StreamBuilder(
    stream: ct,
    /*FirebaseFirestore.instance
        .collection('clientes')
        .snapshots(),*/ //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print("entro getInfo");
      print("snapshot.connectionState: " + snapshot.connectionState.toString());
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaLocations(
                  locations: snapshot.data!.docs, uid: uid, lat: lat, lo: lo)
              : Text('Sin Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaLocations extends StatelessWidget {
  final List locations;
  final String uid;
  final String lat;
  final String lo;

  const VistaLocations(
      {required this.locations,
      required this.uid,
      required this.lat,
      required this.lo});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> listacalculo = [];
    //Controllerlocations controlubicacion = Get.find();

//*********Calculo de Distancias***********//

    double deg2rad(double deg) {
      return (deg * pi / 180.0);
    }

    double rad2deg(double rad) {
      return (rad * 180.0 / pi);
    }

    String distance(
        double lat1, double lon1, double lat2, double lon2, String unit) {
      double theta = lon1 - lon2;
      double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
          cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
      dist = acos(dist);
      dist = rad2deg(dist);
      dist = dist * 60 * 1.1515;
      if (unit == 'K') {
        dist = dist * 1.609344;
      } else if (unit == 'N') {
        dist = dist * 0.8684;
      }
      return dist.toStringAsFixed(2);
    }

    //**********************************//
    print("entro VistaLocations");
    print("locations.length: " + locations.length.toString());

    for (int i = 0; i < locations.length; i++) {
      print("uid: " + locations[i]['uid']);
      if (uid != locations[i]['uid']) {
        String distancia = distance(
            double.parse(lat),
            double.parse(lo),
            //double.parse(locations[i]['lat']),
            //double.parse(locations[i]['lo']),
            locations[i]['lat'],
            locations[i]['lo'],
            'K');

        var calc = <String, dynamic>{
          'name': locations[i]['name'],
          'lat': locations[i]['lat'],
          'lo': locations[i]['lo'],
          'Dist': distancia
        };
        // Se quita validacion de distancia para mostrar todos.
        //if (double.parse(distancia) < 200) listacalculo.add(calc);
        listacalculo.add(calc);
      }
    }

    listacalculo.sort((a, b) {
      return a['Dist'].compareTo(b['Dist']);
    });

    //controlubicacion.cercanos = listacalculo.length.toString();

    return ListView.builder(
        itemCount: listacalculo.length == 0 ? 0 : listacalculo.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, posicion) {
          //print(locations[posicion].id);
          return ListTile(
            leading: IconButton(
              onPressed: () async {
                final url =
                    "https://www.google.es/maps?q=${listacalculo[posicion]['lat']},${listacalculo[posicion]['lo']}";
                await launch(url);
              },
              //icon: Icon(Icons.map_sharp),
              icon: Icon(Icons.map_outlined),
            ),
            title: Text(
                //'Lat: ${listacalculo[posicion]['lat']} Lo: ${listacalculo[posicion]['lo']}'
                'Lat: ${double.parse((listacalculo[posicion]['lat']).toStringAsFixed(6))} Lo: ${double.parse((listacalculo[posicion]['lo']).toStringAsFixed(6))}'
                ),
            subtitle: Text(listacalculo[posicion]['name']),
            trailing: Container(
                height: 30,
                width: 80,
                color: Colors.blue[100],
                //child: Text((double.parse(listacalculo[posicion]['Dist'])/1000).toStringAsFixed(2) + 'km')
                child: Text(listacalculo[posicion]['Dist'])
            ),
          );
        });
  }
}

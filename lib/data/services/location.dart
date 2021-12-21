import 'dart:convert';
import 'package:dynamics_news/domain/models/location.dart';
import 'package:dynamics_news/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class LocationService implements MisionTicService {
  final String baseUrl = 'misiontic-2022-uninorte.herokuapp.com';
  //final String apiKey = 'wNLombyTzPIjLjkfp/aohu5b0Xy.iOM.4Sj4Q3.s9Ri9riyE6y5E2';
  final String apiKey = 'OqnT51YiWJYw1SlQsAUXw./W00jjL4a/hhJ9/ZBQJRoig0UXQgScm';


  @override
  Future<List<UserLocation>> fecthData({int limit = 5, Map? map}) async {
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/location', queryParameters);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // We add our service ApiKey to the request headers
        'key': apiKey,
      },
      body: json.encode(map),
    );
    print("response.statusCode: "+response.statusCode.toString());
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<UserLocation> locations = [];
      for (var location in res['nearme']) {
        locations.add(UserLocation.fromJson(location));
      }
      return locations;
    } else {
      throw Exception('Error on request');
    }
  }

  // Future<List<UserLocation>> fecthData2xx({int limit = 5, Map? map}) async {
  //   var queryParameters = {'limit': limit.toString()};
  //   var uri = Uri.https(baseUrl, '/location', queryParameters);
  //   final response = await http.post(
  //     uri,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       // We add our service ApiKey to the request headers
  //       'key': apiKey,
  //     },
  //     body: json.encode(map),
  //   );
  //   print("response.statusCode: "+response.statusCode.toString());
  //   if (response.statusCode == 200) {
  //     var res = json.decode(response.body);
  //     final List<UserLocation> locations = [];
  //     for (var location in res['nearme']) {
  //       locations.add(UserLocation.fromJson(location));
  //     }
  //     return locations;
  //   } else {
  //     throw Exception('Error on request');
  //   }
  // }



}

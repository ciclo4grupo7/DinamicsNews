import 'package:geolocator/geolocator.dart';
import 'package:dynamics_news/data/services/geolocation.dart';

class LocationManager {
  final gpsService = GpsService();

  Future<Position> getCurrentLocation() async {
    return await gpsService.getCurrentLocation();
  }
}

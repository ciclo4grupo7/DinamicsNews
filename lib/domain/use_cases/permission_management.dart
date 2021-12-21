import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> gpsPermission() async {
    var status = await Permission.location.status;
    return status.isGranted || status.isLimited;
  }

  Future<bool> requestGpsPermission() async {
    var status = await Permission.location.request();
    return status.isGranted || status.isLimited;
  }
}

import 'package:permission_handler/permission_handler.dart';

class PermissionRequest {
  static Future<void> requestPermission() async {
    const permission = Permission.location;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  static Future<bool> checkPermissionStatus() async {
    const permission = Permission.location;
    return await permission.status.isGranted;
  }

  static Future<bool> shouldShowRequestRationale() async {
    const permission = Permission.location;
    return await permission.shouldShowRequestRationale;
  }

  static void openSettings() {
    openAppSettings();
  }
}

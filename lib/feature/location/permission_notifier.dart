import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsNotifier extends AsyncNotifier<bool> {
  bool locationWhenInUseGranted = false;
  bool locationAlwaysGranted = false;

  @override
  Future<bool> build() async {
    return await requestPermissions();
  }

  Future<bool> requestPermissions() async {
    locationWhenInUseGranted =
        await _requestPermission(Permission.locationWhenInUse);
    if (!locationWhenInUseGranted) return false;

    locationAlwaysGranted = await _requestPermission(Permission.locationAlways);
    if (!locationAlwaysGranted) return false;

    state = const AsyncData(
        true); // ✅ Update state when all permissions are granted
    return true;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) return true;
    final status = await permission.request();
    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return status.isGranted;
  }
}

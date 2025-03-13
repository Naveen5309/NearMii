import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';

class LocationService {
  // Singleton instance
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  /// Store the last fetched position
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  /// Check location permission & show dialog if needed
  Future<bool> _handleLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    printLog("permission is :-> # $permission");

    if (permission == LocationPermission.denied) {
      bool proceed = await _showCustomPermissionDialog(context);
      if (!proceed) return false;

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog(context);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {}
      _showPermissionDeniedDialog(context);
      return false;
    }

    return true;
  }

  /// Check if location service (GPS) is enabled
  Future<bool> _checkLocationService(BuildContext context) async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      _showLocationEnableDialog(context);
      return false;
    }
    return true;
  }

  /// Fetch current location and store it
  Future<Position?> getCurrentLocation(BuildContext context) async {
    bool hasPermission = await _handleLocationPermission(context);
    if (!hasPermission) return null;

    bool isServiceEnabled = await _checkLocationService(context);

    printLog("is service enabled:-> $isServiceEnabled");
    if (!isServiceEnabled) return null;

    _currentPosition = await Geolocator.getCurrentPosition();

    if (_currentPosition != null) {
      printLog(
          "Current Location: Lat: ${_currentPosition!.latitude}, Lng: ${_currentPosition!.longitude}");
    } else {
      printLog("Failed to fetch location.");
    }

    return _currentPosition;
  }
}

/// **Show custom permission request dialog**
Future<bool> _showCustomPermissionDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.location_on, color: Colors.blueAccent),
              SizedBox(width: 10),
              Text("Allow Location Access"),
            ],
          ),
          content: const Text(
            "We need your location to provide better services.",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context, true),
              icon: const Icon(Icons.check, size: 18),
              label: const Text("Enable"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ) ??
      false;
}

/// **Show settings dialog if permission is denied**
void _showPermissionDeniedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Row(
        children: [
          Icon(Icons.location_off, color: Colors.redAccent),
          SizedBox(width: 10),
          Text("Permission Required"),
        ],
      ),
      content: const Text(
        "To use this feature, please enable location permissions in settings.",
        style: TextStyle(fontSize: 16),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            Geolocator.openAppSettings();
          },
          icon: const Icon(Icons.settings, size: 18),
          label: const Text("Open Settings"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    ),
  );
}

/// **Show GPS enable dialog if location services are off**
void _showLocationEnableDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(
        children: [
          Lottie.asset(Assets.requestLocationJson,
              fit: BoxFit.fill,
              width: context.width * .5,
              height: context.height * .2),
          const SizedBox(height: 8),
          AppText(
            text: "Enable Location",
            color: AppColor.appThemeColor,
            fontSize: 20.sp,
          ),
        ],
      ),
      content: AppText(
        text: "Please turn on location services to get nearby users",
        fontSize: 16.sp,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pop(context);
            Geolocator.openLocationSettings();
          },
          icon: Icon(Icons.gps_fixed, size: 22.sp),
          label: const Text("Enable"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    ),
  );
}

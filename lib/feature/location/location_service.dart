import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Singleton instance
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  /// Prevent multiple permission dialogs
  bool _isRequestingPermission = false;

  /// Store the last fetched position
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  /// Check location permission & show dialog if needed
  Future<bool> _handleLocationPermission(BuildContext context) async {
    if (_isRequestingPermission) return false; // Prevent duplicate calls
    _isRequestingPermission = true;

    LocationPermission permission = await Geolocator.checkPermission();
    print("Initial Permission: $permission");

    if (permission == LocationPermission.denied) {
      bool proceed = await _showCustomPermissionDialog(context);
      if (!proceed) {
        _isRequestingPermission = false;
        return false;
      }

      permission = await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();

      print("Permission after request: $permission");

      if (permission == LocationPermission.denied) {
        _showPermissionDeniedDialog(context);
        _isRequestingPermission = false;
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        _showPermissionDeniedForeverDialog(context);
      }
      _isRequestingPermission = false;
      return false;
    }

    _isRequestingPermission = false;
    return true;
  }

  /// Show permission denied forever dialog
  void _showPermissionDeniedForeverDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Permission Required"),
          content: const Text(
            "Location permission is permanently denied. Please enable it from the app settings.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close dialog
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings(); // Open app settings
              },
              child: const Text("Open Settings"),
            ),
          ],
        );
      },
    );
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
    if (!isServiceEnabled) return null;

    _currentPosition = await Geolocator.getCurrentPosition();

    if (_currentPosition != null) {
      print(
          "Current Location: Lat: ${_currentPosition!.latitude}, Lng: ${_currentPosition!.longitude}");
    } else {
      print("Failed to fetch location.");
    }

    return _currentPosition;
  }

  /// Show custom permission request dialog
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
                child:
                    const Text("Cancel", style: TextStyle(color: Colors.grey)),
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

  /// Show permission denied dialog
  void _showPermissionDeniedDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);

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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  /// Show GPS enable dialog if location services are off
  void _showLocationEnableDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .popUntil((route) => route.isFirst);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.gps_fixed, color: Colors.green),
            SizedBox(width: 10),
            Text("Enable Location"),
          ],
        ),
        content: const Text(
          "Please turn on location services to get nearby users",
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
              Geolocator.openLocationSettings();
            },
            icon: const Icon(Icons.gps_fixed, size: 18),
            label: const Text("Enable"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }
}

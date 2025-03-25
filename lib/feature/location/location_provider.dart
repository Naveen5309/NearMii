import 'package:NearMii/feature/location/location_service.dart';
import 'package:NearMii/feature/location/permission_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

///RealTime Location
final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final locationProvider = StreamProvider<Position>((ref) {
  final locationService = ref.read(locationServiceProvider);
  final permissionState = ref.watch(permissionsProvider);

  return permissionState.when(
    data: (isGranted) {
      if (!isGranted) {
        print("❌ Location permission denied");
        return const Stream.empty();
      }
      return locationService.getPositionStream().handleError((error) {
        print("🚨 Error fetching location: $error");
      });
    },
    loading: () {
      return const Stream.empty();
    },
    error: (error, stack) {
      print("⚠️ Error fetching permission state: $error");
      return const Stream.empty();
    },
  );
});

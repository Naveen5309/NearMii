import 'dart:developer';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/home/domain/usecases/get_home.dart';
import 'package:NearMii/feature/home/presentation/provider/states/home_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeUseCase homeUseCase;
  HomeNotifier({required this.homeUseCase}) : super(HomeInitial());

  // Location data varibale & methods
  List<Placemark> placemarks = [];
  String addressName = '';
  String location = '';

  bool loader = true;
// Function to get the current location and update the state
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied');
    }
    return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
  }

  double? distance;
  Future<List<Placemark>> getPlaceMark() async {
    Position position = await determinePosition();
    final lat = position.latitude;
    final lng = position.longitude;
    printLog('lat: $lat <--> lng: $lng');
    placemarks = await placemarkFromCoordinates(lat, lng);

    printLog(placemarks);

    return placemarks;
  }

  Future<void> getLocation() async {
    try {
      state = const UpdateLocation(locationType: LocationType.loading);
      List<Placemark> placemarks = await getPlaceMark();
      if (placemarks.isNotEmpty) {
        loader = false;
        addressName = placemarks[0].name ?? '';
        location = '${placemarks[0].locality}, ${placemarks[0].country}';

        await Getters.getLocalStorage.saveAddress(addressName);
        await Getters.getLocalStorage.saveLocation(location);

        state = const UpdateLocation(locationType: LocationType.updated);
      } else {
        loader = false;
        addressName = 'No address found';
        await Getters.getLocalStorage.saveAddress('');
        await Getters.getLocalStorage.saveLocation('');

        state = const UpdateLocation(locationType: LocationType.error);
      }
    } catch (e) {
      loader = false;
      addressName = 'No address found';
      await Getters.getLocalStorage.saveAddress('');
      await Getters.getLocalStorage.saveLocation('');
      state = const UpdateLocation(locationType: LocationType.error);
    }
  }

  checkAddress() async {
    addressName = Getters.getLocalStorage.getAddress() ?? '';
    location = Getters.getLocalStorage.getLocation() ?? '';

    log("address is :-> $addressName");

    if (addressName.isEmpty || location.isEmpty) {
      getLocation();
    }
    addressName = Getters.getLocalStorage.getAddress() ?? '';
    location = Getters.getLocalStorage.getLocation() ?? '';
    state = UpdateLocation2();
  }
}

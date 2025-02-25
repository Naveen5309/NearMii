import 'dart:developer';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/home/data/models/home_data_model.dart';
import 'package:NearMii/feature/home/domain/usecases/get_home.dart';
import 'package:NearMii/feature/home/presentation/provider/states/home_states.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeUseCase homeUseCase;
  HomeNotifier({required this.homeUseCase}) : super(HomeInitial());
  List<HomeData> homeUserDataList = [];

  double lat = 30.710446;
  double long = 76.719350;

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

  //UPDATE COORDINATES
  Future<void> updateCoordinates() async {
    log("update coordinates called");
    state = const HomeApiLoading(homeType: HomeType.coordinates);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const HomeApiFailed(
          homeType: HomeType.coordinates,
          error: AppString.noInternetConnection,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "lat": lat,
        "long": long,
      };
      final result = await homeUseCase.updateCoordinates(
        body: body,
      );
      state = result.fold((error) {
        log("coordiantes update:${error.message} ");

        return HomeApiFailed(
            error: error.message, homeType: HomeType.coordinates);
      }, (result) {
        // userModel = result;

        // clearLoginFields();
        return const HomeApiSuccess(homeType: HomeType.coordinates);
      });
    } catch (e) {
      state =
          HomeApiFailed(error: e.toString(), homeType: HomeType.coordinates);
    }
  }

  // Home Data Api
  Future<void> getHomeDataApi() async {
    state = const HomeApiLoading(homeType: HomeType.home);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const HomeApiFailed(
          homeType: HomeType.home,
          error: AppString.noInternetConnection,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "lat": lat,
        "long": long,
      };
      // Map<String, dynamic> body = {};
      final result = await homeUseCase.callGetHome(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return HomeApiFailed(
          homeType: HomeType.home,
          error: error.message,
        );
      }, (result) {
        if (result != null) {
          homeUserDataList = result;
        } else {
          homeUserDataList = [];
        }
        log("history result is :->$homeUserDataList");
        return const HomeApiSuccess(homeType: HomeType.home);
      });
    } catch (e) {
      state = HomeApiFailed(error: e.toString(), homeType: HomeType.home);
    }
  }

  // //Get Home Data
  // Future<void> getHomeDataApi() async {
  //   state = const HomeApiLoading(locationType: LocationType.homeData);
  //   try {
  //     if (!(await Getters.networkInfo.isConnected)) {
  //       state = const HomeApiFailed(
  //           error: AppString.noInternetConnection,
  //           locationType: LocationType.homeData);
  //       return;
  //     }
  //     if (await Getters.networkInfo.isSlow) {
  //       toast(
  //         msg: AppString.networkSlow,
  //       );
  //     }
  //     Map<String, dynamic> body = {
  //       // "password": currentPasswordController.text.trim(),
  //     };
  //     final result = await homeUseCase.callGetHome();
  //     // printLog("${result?.data??[]} fun:" "GET_LENGTH");

  //     state = result.fold((error) {
  //       log("login error:${error.message} ");
  //       return HomeApiFailed(
  //           error: error.message, locationType: LocationType.homeData);
  //     }, (result) {
  //       printLog((result?.data ?? []).length, fun: "GET_LENGTH");

  //       return const HomeApiSuccess(locationType: LocationType.homeData);
  //     });
  //   } catch (e) {
  //     state = HomeApiFailed(
  //         error: e.toString(), locationType: LocationType.homeData);
  //   }
  // }
}

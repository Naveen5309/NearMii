import 'dart:developer';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/home/data/models/home_data_model.dart';
import 'package:NearMii/feature/home/domain/usecases/get_home_usecases.dart';
import 'package:NearMii/feature/home/presentation/provider/states/home_states.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
import 'package:NearMii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeNotifier extends StateNotifier<HomeState>
    with WidgetsBindingObserver {
  final HomeUseCase homeUseCase;
  HomeNotifier({required this.homeUseCase}) : super(HomeInitial()) {
    WidgetsBinding.instance.addObserver(this);
  }
  List<HomeData> homeUserDataList = [];
  UserProfileModel? userProfileModel;

  // double lat = 30.710446;
  // double long = 76.719350;

  // Location data varibale & methods
  List<Placemark> placemarks = [];
  String addressName = '';
  String location = '';

  bool loader = true;
  Position? currentPosition;
  String profilePic = '';
  String socialImg = '';
  bool isSubscription = false;
  bool isHomeLoading = true;
  bool _isUpdating = false; // ✅ Flag to track API status

  bool isRefreshLoading = false;
  int credits = 0;

  String name = '';

  // / **Detect when app returns from background**
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     printLog("resumed called");
  //     // Re-fetch location when returning from settings
  //     LocationService()
  //         .getCurrentLocation(navigatorKey.currentState!.context)
  //         .then((position) {
  //       if (position != null) {
  //         printLog("Resumed and got location: $position");
  //         currentPosition = position;

  //         updateCoordinates(radius: '');
  //       }
  //     });
  //   }
  // }

  // Future<void> fetchLocation({required BuildContext context}) async {
  //   await Future.delayed(Duration.zero); // Ensures context is available
  //   Position? position = await LocationService().getCurrentLocation(context);
  //   // setState(() {
  //   currentPosition = position;

  //   printLog("current location data :-> $position");

  //   updateCoordinates(radius: '');
  //   // });
  // }

  void getFromLocalStorage() async {
    printLog("get local storage called");
    name = Getters.getLocalStorage.getName() ?? '';
    printLog("get local storage called :-> $name");

    profilePic = Getters.getLocalStorage.getProfilePic() ?? '';
    socialImg = Getters.getLocalStorage.getSocialProfilePic() ?? '';
    isSubscription = Getters.getLocalStorage.getIsSubscription() ?? false;
    credits = Getters.getLocalStorage.getCredits() ?? 0;
  }

// Function to get the current location and update the state
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool shouldOpenSettings =
          await showLocationDialog(navigatorKey.currentState!.context);
      if (shouldOpenSettings) {
        await Geolocator.openLocationSettings();
      }
      return Future.error('Location services are disabled.');
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied. Enable them from settings.');
    }

    // Get the current position
    return await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));
  }

// Function to show a dialog asking the user to enable location services
  Future<bool> showLocationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Enable Location"),
              content: const Text(
                  "Location services are disabled. Please enable them to continue."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text("Open Settings"),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if the user dismisses the dialog
  }

  Future<List<Placemark>> getPlaceMark() async {
    Position position = await determinePosition();
    final lat = position.latitude;
    final lng = position.longitude;
    printLog('lat: $lat <--> lng: $lng');
    placemarks = await placemarkFromCoordinates(lat, lng);
    GeocodingPlatform.instance!.setLocaleIdentifier(
      "en_US",
    );

    printLog(placemarks);

    return placemarks;
  }

  Future<void> getLocation() async {
    try {
      state = const UpdateLocation(locationType: LocationType.loading);
      List<Placemark> placemarks = await getPlaceMark();
      if (placemarks.isNotEmpty) {
        printLog("locality is :--------> ");
        printLog(placemarks[0].administrativeArea ??
            " ,${placemarks[0].locality ?? ''}--->");
        loader = false;
        addressName =
            '${placemarks[0].administrativeArea}, ${placemarks[0].locality}';

        location =
            '${placemarks[0].street ?? placemarks[0].name}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].subLocality}';

        await Getters.getLocalStorage.saveAddress(addressName);
        await Getters.getLocalStorage.saveLocation(location);

        state = const UpdateLocation(locationType: LocationType.updated);
      } else {
        loader = false;
        addressName = 'No address found';

        state = const UpdateLocation(locationType: LocationType.error);
      }
    } catch (e) {
      log("location error $e");
      loader = false;
      addressName = 'No address found';

      state = const UpdateLocation(locationType: LocationType.error);
    }
  }

//Check address
  Future<void> checkAddress() async {
    // Check location permission
    PermissionStatus permission = await Permission.location.status;

    if (permission.isGranted) {
      await _checkLocationServiceAndProceed();
    } else {
      // Request location permission
      PermissionStatus newPermission = await Permission.location.request();
      if (newPermission.isGranted) {
        checkAddress(); // Re-run function after permission is granted
      } else {
        print("Location permission denied");
      }
    }
  }

  Future<void> _checkLocationServiceAndProceed() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      bool shouldOpenSettings = await Geolocator.openLocationSettings();

      if (shouldOpenSettings) {
        // Wait a few seconds for the user to turn on location and then recheck
        Future.delayed(const Duration(seconds: 3), () async {
          bool isEnabledNow = await Geolocator.isLocationServiceEnabled();
          if (isEnabledNow) {
            getLocation();
          } else {
            print("User did not enable location services");
          }
        });
      } else {
        print("User chose not to open location settings");
      }
    } else {
      // If location is already enabled, proceed to get location
      getLocation();
    }
  }

  // checkAddress() async {
  //   // addressName = Getters.getLocalStorage.getAddress() ?? '';
  //   // location = Getters.getLocalStorage.getLocation() ?? '';

  //   // log("address is :-> $addressName");

  //   // if (addressName.isEmpty || location.isEmpty) {
  //   getLocation();
  //   // }

  //   state = UpdateLocation2();
  // }

  // UPDATE COORDINATES

  Future<void> updateCoordinates({
    required String radius,
    required double lat,
    required double lang,
  }) async {
    if (_isUpdating) {
      log("⚠️ Skipping API call: Previous request is still in progress.");
      return; // ❌ Skip if previous request is not finished
    }

    _isUpdating = true; // ✅ Set flag before hitting API
    log("📡 updateCoordinates called");

    state = const HomeApiLoading(homeType: HomeType.coordinates);

    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const HomeApiFailed(
          homeType: HomeType.coordinates,
          error: AppString.noInternetConnection,
        );
        _isUpdating = false;
        return;
      }

      if (await Getters.networkInfo.isSlow) {
        toast(msg: AppString.networkSlow);
      }

      Map<String, dynamic> body = {
        "lat": lat,
        "long": lang,
        if (radius.isNotEmpty) "radius": radius,
      };

      final result = await homeUseCase.updateCoordinates(body: body);

      state = result.fold(
        (error) {
          log("❌ API Error: ${error.message}");
          _isUpdating = false; // ✅ Reset flag on failure
          return HomeApiFailed(
              error: error.message, homeType: HomeType.coordinates);
        },
        (success) {
          log("✅ API Success");
          _isUpdating = false; // ✅ Reset flag on success

          getHomeDataApi(lat: lat, lang: lang);
          return const HomeApiSuccess(homeType: HomeType.coordinates);
        },
      );
    } catch (e) {
      log("❌ Exception: $e");
      state =
          HomeApiFailed(error: e.toString(), homeType: HomeType.coordinates);
      _isUpdating = false; // ✅ Reset flag on error
    }
  }

  // Home Data Api
  Future<void> getHomeDataApi({
    required double lat,
    required double lang,
    bool isFromRefresh = false,
  }) async {
    if (!isFromRefresh) isHomeLoading = true;
    if (isFromRefresh) isRefreshLoading = true;
    state = const HomeApiLoading(homeType: HomeType.home);
    try {
      checkAddress();
      if (!(await Getters.networkInfo.isConnected)) {
        if (!isFromRefresh) isHomeLoading = false;
        if (isFromRefresh) isRefreshLoading = false;

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
        "long": lang,
      };
      // Map<String, dynamic> body = {};
      final result = await homeUseCase.callGetHome(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        if (!isFromRefresh) isHomeLoading = false;
        if (isFromRefresh) isRefreshLoading = false;

        return HomeApiFailed(
          homeType: HomeType.home,
          error: error.message,
        );
      }, (result) {
        log("getHomeDataApi result is :->2 $result");
        log("getHomeDataApi result is isSubscription :->1 ${result["isSubscription"]}");

        // log("getHomeDataApi result is :->2 ${result["data "]}");

        if (result != null && result["data"] != null) {
          homeUserDataList = (result["data"] as List)
              .map((item) => HomeData.fromJson(item))
              .toList();

          credits = result["user_points"] ?? 0;
          isSubscription = (result["isSubscription"] == 1) ? true : false;

          Getters.getLocalStorage.saveCredits(credits);
          Getters.getLocalStorage.saveIsSubscription(isSubscription);

          log("getHomeDataApi result is isSubscription :->2 $isSubscription");
        } else {
          homeUserDataList = [];
        }
        log("history result is :->$homeUserDataList");
        log("user_points are :->$credits");

        if (!isFromRefresh) isHomeLoading = false;
        if (isFromRefresh) isRefreshLoading = false;

        return const HomeApiSuccess(homeType: HomeType.home);
      });
    } catch (e) {
      printLog("catch called");
      if (!isFromRefresh) isHomeLoading = false;
      if (isFromRefresh) isRefreshLoading = false;

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
  // AddSubscription
  Future<void> addSubscription() async {
    state = const HomeApiLoading(homeType: HomeType.getAddSubscription);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const HomeApiFailed(
            error: AppString.noInternetConnection,
            homeType: HomeType.getAddSubscription);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {};

      log("body is :->$body");
      final result = await homeUseCase.calAddSubscription(
        body: body,
      );
      state = result.fold((error) {
        log("login error:${error.message} ");
        return HomeApiFailed(
            error: error.message, homeType: HomeType.getAddSubscription);
      }, (result) {
        printLog("result is::$result");

        return const HomeApiSuccess(homeType: HomeType.getAddSubscription);
      });
    } catch (e) {
      state = HomeApiFailed(
          error: e.toString(), homeType: HomeType.getAddSubscription);
    }
  }
}

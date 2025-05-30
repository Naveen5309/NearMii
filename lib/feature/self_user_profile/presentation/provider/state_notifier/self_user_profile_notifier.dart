import 'dart:developer';
import 'package:NearMii/config/countries.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/new_other_user_social_platform.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/self_user_profile/domain/usecases/self_user_profile_usecases.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state/self_user_profile_state.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelfUserProfileNotifier extends StateNotifier<SelfUserProfileState> {
  final SelfUserProfileUsecases selfUserProfileUsecases;

  SelfUserProfileNotifier({required this.selfUserProfileUsecases})
      : super(SelfUserProfileInitial());
  UserProfileModel? userProfileModel;

  TextEditingController searchTextController = TextEditingController();
  TextEditingController platformTextController = TextEditingController();

  List<SelfPlatformCatagoryData> newPlatformLists = [];
  List<SelfPlatformCatagoryData> newPlatformListsProfile = [];

  List<SelfPlatformCatagoryData> profilePlatformListsProfile = [];

  String countryCode = '+1';
  String countryNameCode = 'US';

  String countryFlag = '🇺🇸';

  //SelfUserProfile US
  Future<void> updateSocialLinksApi(
      {required String id,
      required Country county,
      required bool isPhone}) async {
    printLog("country is:-. ${county.dialCode}");
    state = const SelfUserProfileApiLoading(
      selfProfileDataType: SelfProfileDataType.updatePlatform,
    );
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
          error: AppString.noInternetConnection,
          selfProfileDataType: SelfProfileDataType.updatePlatform,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "id": id,
        "url": isPhone
            ? "${county.dialCode} ${platformTextController.text.trim()}"
            : platformTextController.text.trim(),
      };

      printLog("update platform is :-> $body");
      final result =
          await selfUserProfileUsecases.callUpdateSocialProfile(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(
          error: error.message,
          selfProfileDataType: SelfProfileDataType.updatePlatform,
        );
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->$result");
        return const SelfUserProfileApiSuccess(
          selfProfileDataType: SelfProfileDataType.updatePlatform,
        );
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(
        error: e.toString(),
        selfProfileDataType: SelfProfileDataType.updatePlatform,
      );
    }
  }

  //HIDE ALL LINK
  Future<void> hideAllLinksApi({required int hideProfile}) async {
    state = const SelfUserProfileApiLoading(
      selfProfileDataType: SelfProfileDataType.hideAll,
    );
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
          error: AppString.noInternetConnection,
          selfProfileDataType: SelfProfileDataType.hideAll,
        );

        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {"hideProfile": hideProfile};
      final result = await selfUserProfileUsecases.callHideAllLinks(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(
          error: error.message,
          selfProfileDataType: SelfProfileDataType.hideAll,
        );
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->$result");
        return const SelfUserProfileApiSuccess(
          selfProfileDataType: SelfProfileDataType.hideAll,
        );
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(
        error: e.toString(),
        selfProfileDataType: SelfProfileDataType.hideAll,
      );
    }
  }

  //HIDE PLATFORM
  Future<void> hidePlatformApi({required String platformId}) async {
    state = SelfUserProfileInitial();
    state = const SelfUserProfileApiLoading(
      selfProfileDataType: SelfProfileDataType.hidePlatform,
    );
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
          error: AppString.noInternetConnection,
          selfProfileDataType: SelfProfileDataType.hidePlatform,
        );

        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {"id": platformId};
      final result = await selfUserProfileUsecases.hidePlatform(body: body);
      state = result.fold((error) {
        log("login error:${error.message}");
        return SelfUserProfileApiFailed(
          error: error.message,
          selfProfileDataType: SelfProfileDataType.hidePlatform,
        );
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->$result");
        getProfileApi();

        return const SelfUserProfileApiSuccess(
          selfProfileDataType: SelfProfileDataType.hidePlatform,
        );
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(
        error: e.toString(),
        selfProfileDataType: SelfProfileDataType.hidePlatform,
      );
    }
  }

  //VALIDATE ADD PLATFORM
  bool validatePhoneNumber() {
    bool isValid = Validator().validatePhoneNumber(
        phoneNumber: platformTextController.text.trim(),
        countryCode: countryCode);
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //VALIDATE UPDATE PLATFORM
  bool validateAddPlatform({required String type}) {
    bool isValid = Validator().addPlatformValidator(
        url: platformTextController.text.trim(), type: type);
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //SelfUserProfile US
  Future<void> getSelfPlatformApi() async {
    state = const SelfUserProfileApiLoading(
        selfProfileDataType: SelfProfileDataType.getPlatform);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
          selfProfileDataType: SelfProfileDataType.getPlatform,
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
        "name": searchTextController.text.trim(),
      };
      final result =
          await selfUserProfileUsecases.callGetSelfPlatform(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(
            error: error.message,
            selfProfileDataType: SelfProfileDataType.getPlatform);
      }, (result) {
        newPlatformLists = result;
        newPlatformListsProfile = result;

        if (searchTextController.text.trim().isEmpty) {
          profilePlatformListsProfile = result;
        }
        newPlatformLists = newPlatformLists
            .where((platformCatagory) =>
                platformCatagory.list != null &&
                platformCatagory.list!.isNotEmpty)
            .toList();

        return const SelfUserProfileApiSuccess(
            selfProfileDataType: SelfProfileDataType.getPlatform);
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(
          error: e.toString(),
          selfProfileDataType: SelfProfileDataType.getPlatform);
    }
  }

  //SelfUserProfile US
  Future<void> deletePlatformApi({required String id}) async {
    state = const SelfUserProfileApiLoading(
      selfProfileDataType: SelfProfileDataType.deletePlatform,
    );
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
            error: AppString.noInternetConnection,
            selfProfileDataType: SelfProfileDataType.deletePlatform);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "id": id,
      };
      final result = await selfUserProfileUsecases.callDelete(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(
          error: error.message,
          selfProfileDataType: SelfProfileDataType.deletePlatform,
        );
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->$result");
        return const SelfUserProfileApiSuccess(
          selfProfileDataType: SelfProfileDataType.deletePlatform,
        );
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(
        error: e.toString(),
        selfProfileDataType: SelfProfileDataType.deletePlatform,
      );
    }
  }

  //Get Profile
  Future<void> getProfileApi() async {
    state = const SelfUserProfileApiLoading(
      selfProfileDataType: SelfProfileDataType.getProfile,
    );
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
          error: AppString.noInternetConnection,
          selfProfileDataType: SelfProfileDataType.getProfile,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        // "password": currentPasswordController.text.trim(),
      };
      final result =
          await selfUserProfileUsecases.callGetSocialProfile(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(
          error: error.message,
          selfProfileDataType: SelfProfileDataType.getProfile,
        );
      }, (result) {
        userProfileModel = result;
        // getSelfPlatformApi();

        return const SelfUserProfileApiSuccess(
          selfProfileDataType: SelfProfileDataType.getProfile,
        );
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(
        error: e.toString(),
        selfProfileDataType: SelfProfileDataType.getProfile,
      );
    }
  }

  updateUserPhone({required String phoneNumber}) {
    platformTextController.text = phoneNumber.split(' ').last;
    countryCode = phoneNumber.split(' ').first;

    printLog("phone :-> $phoneNumber , $countryCode");
  }
}

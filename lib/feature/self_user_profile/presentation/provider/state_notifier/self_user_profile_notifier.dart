import 'dart:developer';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/get_my_platform_model.dart';
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
  List<SelfPlatformData> socialMediaList = [];
  List<SelfPlatformData> contactList = [];
  List<SelfPlatformData> portfolioList = [];
  List<SelfPlatformData> financeList = [];
  List<SelfPlatformData> businessList = [];

  TextEditingController searchTextController = TextEditingController();

  //SelfUserProfile US
  Future<void> updateSocialLinksApi(
      {required String id, required String url}) async {
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
        "url": url,
      };
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

  //SelfUserProfile US
  Future<void> hideAllLinksApi() async {
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
      Map<String, dynamic> body = {};
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
        socialMediaList = result.socialMedia ?? [];
        contactList = result.contactInformation ?? [];
        portfolioList = result.portfolio ?? [];

        // historyDataList = result ?? [];
        log("socialmedialist result is :->$result");
        log("socialmedialist result is :->$socialMediaList");
        log("socialmedialist result is :->$contactList");
        log("socialmedialist result is :->$portfolioList");

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
  Future<void> deleteApi({required String id}) async {
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
}

import 'dart:developer';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/new_other_user_social_platform.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/other_user_profile/data/domain/other_user_profile_usecases.dart';
import 'package:NearMii/feature/other_user_profile/data/model/other_user_profile_model.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states/other_user_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherUserProfileNotifier extends StateNotifier<OtherUserProfileStates> {
  final OtherUserProfileUsecases otherUserProfileUsecases;
  final nameController = TextEditingController();
  final platformSearchController = TextEditingController();
  final reasonController = TextEditingController();

  final designationController = TextEditingController();
  final imageUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final portfolioController = TextEditingController();
  final contactController = TextEditingController();
  final financePasswordController = TextEditingController();
  final businessPasswordController = TextEditingController();

  final somethingElseController = TextEditingController();

  List<SelfPlatformCatagoryData> newPlatformLists = [];
  List<SelfPlatformCatagoryData> newPlatformListProfile = [];
  List<SelfPlatformCatagoryData> otherUserPlatformListProfile = [];

  bool isOtherPlatformLoading = true;
  OtherUserProfileModel? profile;

  bool isLoading = true;

  OtherUserProfileNotifier({required this.otherUserProfileUsecases})
      : super(OtherUserProfileInitial());
  //VALIDATE SIGN UP

  //LOGIN
  Future<void> otherUserProfileApi(String id) async {
    state = const OtherUserProfileApiLoading(
        otherUserType: OtherUserType.getProfile);
    isLoading = true;
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const OtherUserProfileApiFailed(
            error: AppString.noInternetConnection,
            otherUserType: OtherUserType.getProfile);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "user_id": id,
      };
      final result = await otherUserProfileUsecases.callOtherUserProfile(
        body: body,
      );
      state = result.fold((error) {
        log("login error:${error.message} ");
        isLoading = false;

        return OtherUserProfileApiFailed(
            error: error.message, otherUserType: OtherUserType.getProfile);
      }, (result) {
        profile = result;
        isLoading = false;

        return const OtherUserProfileApiSuccess(
            otherUserType: OtherUserType.getProfile);
      });
    } catch (e) {
      isLoading = false;

      state = OtherUserProfileApiFailed(
          error: e.toString(), otherUserType: OtherUserType.getProfile);
    }
  }

  //GET SOCIAL PROFILES
  Future<void> getOtherSocialPlatform({required String userId}) async {
    state = const OtherUserProfileApiLoading(
        otherUserType: OtherUserType.getPlatform);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const OtherUserProfileApiFailed(
            error: "No internet connection",
            otherUserType: OtherUserType.getPlatform);
        return;
      }

      final result = await otherUserProfileUsecases.getOtherPlatformApi(body: {
        "search": platformSearchController.text.trim(),
        "user_id": userId
      });
      state = result.fold((error) {
        return OtherUserProfileApiFailed(
            error: error.message, otherUserType: OtherUserType.getPlatform);
      }, (result) {
        newPlatformLists = result;
        newPlatformListProfile = result;

        if (platformSearchController.text.trim().isEmpty) {
          otherUserPlatformListProfile = result;
        }

        newPlatformLists = newPlatformLists
            .where((platformCatagory) =>
                platformCatagory.list != null &&
                platformCatagory.list!.isNotEmpty)
            .toList();

        log("social media result is:->1 platfomlist $result");

        return const OtherUserProfileApiSuccess(
            otherUserType: OtherUserType.getPlatform);
      });
    } catch (e) {
      state = OtherUserProfileApiFailed(
          error: e.toString(), otherUserType: OtherUserType.getPlatform);
    }
  }

  //Report
  Future<void> reportApi(
      {required String reportedUserId,
      required String somethingElse,
      required String reason}) async {
    state =
        const OtherUserProfileApiLoading(otherUserType: OtherUserType.report);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const OtherUserProfileApiFailed(
            error: AppString.noInternetConnection,
            otherUserType: OtherUserType.report);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "reported_user_id": reportedUserId,
        "reason": reason,
        "something_else": somethingElse,
      };

      log("body is :->$body");
      final result = await otherUserProfileUsecases.callReport(
        body: body,
      );
      state = result.fold((error) {
        log("login error:${error.message} ");
        return OtherUserProfileApiFailed(
            error: error.message, otherUserType: OtherUserType.report);
      }, (result) {
        printLog("result is::$result");

        return const OtherUserProfileApiSuccess(
            otherUserType: OtherUserType.report);
      });
    } catch (e) {
      state = OtherUserProfileApiFailed(
          error: e.toString(), otherUserType: OtherUserType.report);
    }
  }

  void clearAllChecks() {
    if (state is OtherUserProfileApiSuccess) {
      final currentState = state as OtherUserProfileApiSuccess;

      state = OtherUserProfileApiSuccess(
        otherUserType: currentState.otherUserType,
        reasons: currentState.reasons
            .map((reason) => reason.copyWith(check: false))
            .toList(),
      );
    }
  }
}

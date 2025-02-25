import 'dart:developer';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/custom_report_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/other_user_profile/data/domain/other_user_profile_usecases.dart';
import 'package:NearMii/feature/other_user_profile/data/model/other_user_profile_model.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states/other_user_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtherUserProfileNotifier extends StateNotifier<OtherUserProfileStates> {
  final OtherUserProfileUsecases otherUserProfileUsecases;
  final nameController = TextEditingController();
  final designationController = TextEditingController();
  final imageUrlController = TextEditingController();
  final descriptionController = TextEditingController();
  final portfolioController = TextEditingController();
  final contactController = TextEditingController();
  final financePasswordController = TextEditingController();
  final businessPasswordController = TextEditingController();

  List<PlatformData> socialMediaList = [];
  List<PlatformData> contactList = [];

  List<PlatformData> portfolioList = [];

  OtherUserProfileModel? profile;

  OtherUserProfileNotifier({required this.otherUserProfileUsecases})
      : super(OtherUserProfileInitial());
  //VALIDATE SIGN UP
  // bool validateLogin() {
  //   bool isValid = Validator().loginValidator(
  //       email: emailController.text.trim(),
  //       password: passwordController.text.trim());
  //   if (isValid) {
  //     return true;
  //   } else {
  //     toast(msg: Validator().error, isError: true);
  //     return false;
  //   }
  // }
  // SIGN UP

  //LOGIN
  Future<void> otherUserProfileApi(String id) async {
    state = const OtherUserProfileApiLoading(
        otherUserType: OtherUserType.otherUserProfile);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const OtherUserProfileApiFailed(
            error: AppString.noInternetConnection,
            otherUserType: OtherUserType.otherUserProfile);
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
        return OtherUserProfileApiFailed(
            error: error.message,
            otherUserType: OtherUserType.otherUserProfile);
      }, (result) {
        profile = result;
        return const OtherUserProfileApiSuccess(
            otherUserType: OtherUserType.otherUserProfile);
      });
    } catch (e) {
      state = OtherUserProfileApiFailed(
          error: e.toString(), otherUserType: OtherUserType.otherUserProfile);
    }
  }

  //GET SOCIAL PROFILES
  Future<void> getSocialPlatform() async {
    state = const OtherUserProfileApiLoading(
        otherUserType: OtherUserType.otherUserProfile);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const OtherUserProfileApiFailed(
            error: "No internet connection",
            otherUserType: OtherUserType.otherUserProfile);
        return;
      }

      final result = await otherUserProfileUsecases.getPlatformApi(body: {});
      state = result.fold((error) {
        return OtherUserProfileApiFailed(
            error: error.message,
            otherUserType: OtherUserType.otherUserProfile);
      }, (result) {
        log("result is:-> $result");

        // socialMediaList = result.\ ?? [];
        // portfolioList = result.portfolio ?? [];
        // contactList = result.contactInformation ?? [];

        log("result is 15:-> $socialMediaList");

        // Update the list and notify UI by updating state
        // platformDataList = result ?? [];
        return const OtherUserProfileApiSuccess(
            otherUserType: OtherUserType.otherUserProfile);
      });
    } catch (e) {
      state = OtherUserProfileApiFailed(
          error: e.toString(), otherUserType: OtherUserType.otherUserProfile);
    }
  }

  //Report
  Future<void> reportApi(
      {required String reportedUserId, required String somethingElse}) async {
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
        return const OtherUserProfileApiSuccess(
            otherUserType: OtherUserType.report);
      });
    } catch (e) {
      state = OtherUserProfileApiFailed(
          error: e.toString(), otherUserType: OtherUserType.report);
    }
  }

  void updateCheck(int index) {
    if (state is OtherUserProfileApiSuccess) {
      final currentState = state as OtherUserProfileApiSuccess;

      if (index < 0 || index >= (currentState.reasons.length ?? 0)) return;

      final updatedReasons =
          List<CustomReportTile>.from(currentState.reasons ?? []);

      updatedReasons[index] = CustomReportTile(
        title: updatedReasons[index].title,
        check: !updatedReasons[index].check, // ✅ Toggle karein
        ontap: () => updateCheck(index),
      );

      // State ko update karein
      state = OtherUserProfileApiSuccess(
        otherUserType: currentState.otherUserType,
        reasons: updatedReasons,
      );
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

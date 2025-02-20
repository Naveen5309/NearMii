import 'dart:developer';
import 'dart:io';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/data/domain/usecases/setting_usecases.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingNotifier extends StateNotifier<SettingStates> {
  final SettingUsecases settingUseCase;
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final referralController = TextEditingController();
  final dobController = TextEditingController();
  final bioController = TextEditingController();
  final currentPasswordController = TextEditingController();
  final reasonController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final designationController = TextEditingController();

  final genderController = TextEditingController();

  List<PlatformData> platformDataList = [];

  SettingNotifier({required this.settingUseCase}) : super(SettingInitial());

  //VALIDATE Edit Profile
  bool validateEditProfile() {
    bool isValid = Validator().completeEditProfileValidator(
        fullName: fullNameController.text.trim(),
        dob: dobController.text.trim(),
        designation: designationController.text.trim(),
        gender: genderController.text.trim(),
        phoneNumber: phoneController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //VALIDATE Change Password
  bool validateChangePassword() {
    bool isValid = Validator().changePasswordValidation(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

//VALIDATE  Contact us
  bool validateContactUs() {
    bool isValid = Validator().contactUsValidator(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      subject: subjectController.text.trim(),
      message: messageController.text.trim(),
    );

    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //VALIDATE Delete Account
  bool validateDeleteAccount() {
    bool isValid = Validator().deleteAccountValidation(
      currentPassword: currentPasswordController.text.trim(),
    );
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //Contact US
  Future<void> contactUSApi() async {
    state = const SettingApiLoading(settingType: Setting.contactUs);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SettingApiFailed(
            error: AppString.noInternetConnection,
            settingType: Setting.contactUs);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
        "subject": subjectController.text.trim(),
        "message": messageController.text.trim(),
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_token": "No Token",
      };
      final result = await settingUseCase.callContactUs(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return SettingApiFailed(
            error: error.message, settingType: Setting.contactUs);
      }, (result) {
        return const SettingApiSuccess(settingType: Setting.contactUs);
      });
    } catch (e) {
      state =
          SettingApiFailed(error: e.toString(), settingType: Setting.contactUs);
    }
  }

  //Delete Account
  Future<void> deleteAccountApi() async {
    state = const SettingApiLoading(settingType: Setting.deleteAccount);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SettingApiFailed(
            error: AppString.noInternetConnection,
            settingType: Setting.deleteAccount);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "password": currentPasswordController.text.trim(),
      };
      final result = await settingUseCase.callDeleteAccount(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return SettingApiFailed(
            error: error.message, settingType: Setting.deleteAccount);
      }, (result) {
        return const SettingApiSuccess(settingType: Setting.deleteAccount);
      });
    } catch (e) {
      state = SettingApiFailed(
          error: e.toString(), settingType: Setting.deleteAccount);
    }
  }

  //Radius
  Future<void> radiusApi() async {
    state = const SettingApiLoading(settingType: Setting.radius);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SettingApiFailed(
            error: AppString.noInternetConnection, settingType: Setting.radius);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {};
      final result = await settingUseCase.callRadius(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return SettingApiFailed(
            error: error.message, settingType: Setting.radius);
      }, (result) {
        return const SettingApiSuccess(settingType: Setting.radius);
      });
    } catch (e) {
      state =
          SettingApiFailed(error: e.toString(), settingType: Setting.radius);
    }
  }

  //Profile
  Future<void> profileApi() async {
    state = const SettingApiLoading(settingType: Setting.profile);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SettingApiFailed(
            error: AppString.noInternetConnection,
            settingType: Setting.profile);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "password": currentPasswordController.text.trim(),
      };
      final result = await settingUseCase.callProfile(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return SettingApiFailed(
            error: error.message, settingType: Setting.profile);
      }, (result) {
        return const SettingApiSuccess(settingType: Setting.profile);
      });
    } catch (e) {
      state =
          SettingApiFailed(error: e.toString(), settingType: Setting.profile);
    }
  }

  //Get Profile
  Future<void> getProfileApi() async {
    state = const SettingApiLoading(settingType: Setting.getProfile);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SettingApiFailed(
            error: AppString.noInternetConnection,
            settingType: Setting.getProfile);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "password": currentPasswordController.text.trim(),
      };
      final result = await settingUseCase.callGetProfile(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return SettingApiFailed(
            error: error.message, settingType: Setting.getProfile);
      }, (result) {
        return const SettingApiSuccess(settingType: Setting.getProfile);
      });
    } catch (e) {
      state = SettingApiFailed(
          error: e.toString(), settingType: Setting.getProfile);
    }
  }
}

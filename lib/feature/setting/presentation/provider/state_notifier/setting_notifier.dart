import 'dart:developer';

import 'package:NearMii/config/countries.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/data/domain/usecases/setting_usecases.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
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

  String countryCode = '+1';
  String countryFlag = '🇺🇸';

  // List<UserProfileModel> getProfileDataList = [];
  UserProfileModel? userProfileModel;

  List<PlatformData> platformDataList = [];

  SettingNotifier({required this.settingUseCase}) : super(SettingInitial());

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
      reason: reasonController.text.trim(),
      currentPassword: currentPasswordController.text.trim(),
    );
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //VALIDATE Delete Account
  bool validateDeleteAccountSocial() {
    bool isValid = Validator().deleteAccountValidationSocial(
      reason: reasonController.text.trim(),
    );
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

//GET FLAG WITH CONUNTRY CODE
  String? getFlagByDialCode(String dialCode) {
    final country = allCountries.firstWhere(
      (c) => c.dialCode == dialCode,
      orElse: () => const Country(
        name: "",
        flag: "",
        code: "",
        dialCode: "",
        minLength: 0,
        maxLength: 0,
      ),
    );

    return country.flag!.isNotEmpty ? country.flag : null;
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
      };
      final result = await settingUseCase.callContactUs(body: body);
      state = result.fold((error) {
        log("contact api error:${error.message} ");
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
  Future<void> deleteAccountApi({String? socialId}) async {
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
        if (socialId == null) "password": currentPasswordController.text.trim(),
        if (socialId != null) "social_id": socialId,
        "reason": reasonController.text.trim()
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
        // "password": currentPasswordController.text.trim(),
      };
      final result = await settingUseCase.callGetProfile(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SettingApiFailed(
            error: error.message, settingType: Setting.getProfile);
      }, (result) {
        log("result is :-> $result");
        userProfileModel = result;

        if (userProfileModel?.phoneNumber != null) {
          countryCode =
              userProfileModel?.phoneNumber.toString().split(' ').first ?? "+1";
          countryFlag = getFlagByDialCode(countryCode) ?? '🇺🇸';

          Getters.getLocalStorage.saveName(userProfileModel?.name);
          Getters.getLocalStorage
              .saveProfileImg(userProfileModel?.profilePhoto ?? '');

          Getters.getLocalStorage
              .saveSocialImg(userProfileModel?.socialImage ?? '');
        }

        return const SettingApiSuccess(settingType: Setting.getProfile);
      });
    } catch (e) {
      state = SettingApiFailed(
          error: e.toString(), settingType: Setting.getProfile);
    }
  }
}

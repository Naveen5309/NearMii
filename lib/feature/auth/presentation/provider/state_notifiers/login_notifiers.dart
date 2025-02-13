import 'dart:developer';
import 'dart:io';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/helpers/all_getter.dart';
import '../../../domain/usecases/get_auth.dart';
import '../states/auth_states.dart';

class LoginNotifier extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final referralController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  List<PlatformData> socialMediaList = [];
  List<PlatformData> contactList = [];

  List<PlatformData> portfolioList = [];

  LoginNotifier({required this.authUseCase}) : super(AuthInitial());
  //VALIDATE SIGN UP
  bool validateLogin() {
    bool isValid = Validator().loginValidator(
        email: emailController.text.trim(),
        password: passwordController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  // //--------> LOGIN API <--------- //
  // Future<void> login() async {
  //   state = const AuthApiLoading(authType: AuthType.login);
  //   try {
  //     if (!(await Getters.networkInfo.isConnected)) {
  //       state = const AuthApiFailed(
  //           error: "No internet connection", authType: AuthType.login);
  //       return;
  //     }
  //     if (await Getters.networkInfo.isSlow) {
  //       toast(msg: AppString.networkSlow);
  //     }
  //     Map<String, dynamic> body = {
  //       "email": emailController.text.trim(),
  //       "password": passwordController.text.trim(),
  //       "device_token": "device token goes here",
  //       "device_type": Platform.isIOS ? "ios" : "android",
  //     };
  //     final result = await authUseCase.callLogin(body: body);
  //     state = result.fold((error) {
  //       return AuthApiFailed(error: error.message, authType: AuthType.login);
  //     }, (result) {
  //       return const AuthApiSuccess(authType: AuthType.login);
  //     });
  //   } catch (e) {
  //     state = AuthApiFailed(error: e.toString(), authType: AuthType.login);
  //   }
  // }

  //VALIDATE Create New Password
  bool validateCreateNewPassword() {
    bool isValid = Validator().createNewPasswordValidation(
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

//LOGIN
  Future<void> loginApi() async {
    state = const AuthApiLoading(authType: AuthType.login);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection, authType: AuthType.login);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_token": "No Token",
      };
      final result = await authUseCase.callLogin(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return AuthApiFailed(error: error.message, authType: AuthType.login);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.login);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.login);
    }
  }

//GET SOCIAL PROFILES
  Future<void> getSocialPlatform() async {
    state = const AuthApiLoading(authType: AuthType.socialMedia);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: "No internet connection", authType: AuthType.socialMedia);
        return;
      }

      final result = await authUseCase.getPlatform();
      state = result.fold((error) {
        return AuthApiFailed(
            error: error.message, authType: AuthType.socialMedia);
      }, (result) {
        log("result is:-> $result");
        socialMediaList = result.socialMedia ?? [];
        portfolioList = result.portfolio ?? [];
        contactList = result.contactInformation ?? [];

        log("result is 15:-> $socialMediaList");

        // Update the list and notify UI by updating state
        // platformDataList = result ?? [];
        return const AuthApiSuccess(
          authType: AuthType.socialMedia,
        );
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.socialMedia);
    }
  }

//LOG OUT

  //LOGOUT
  Future<void> logOutApi() async {
    state = const AuthApiLoading(authType: AuthType.logOut);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection, authType: AuthType.logOut);
        return;
      }
      if (await Getters.networkInfo.isSlow) {}
      // Map<String, dynamic> body = {};
      final result = await authUseCase.logOut();
      state = result.fold((error) {
        log("login error:${error.message} ");
        return AuthApiFailed(error: error.message, authType: AuthType.logOut);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.logOut);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.logOut);
    }
  }
}

import 'dart:developer';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/usecases/get_auth.dart';
import '../states/auth_states.dart';

class SignupNotifiers extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final otpController = TextEditingController();

  final emailController = TextEditingController();
  final referralController = TextEditingController();
  final pswdController = TextEditingController();
  final confirmPswdController = TextEditingController();
  final dobController = TextEditingController();
  final bioController = TextEditingController();

  final designationController = TextEditingController();

  final genderController = TextEditingController();

  List<PlatformData> platformDataList = [];

  SignupNotifiers({required this.authUseCase}) : super(AuthInitial());

  //VALIDATE SIGN UP
  bool validateSignUp() {
    bool isValid = Validator().signUpValidator(
      email: emailController.text.trim(),
      password: pswdController.text.trim(),
      confirmPassword: confirmPswdController.text.trim(),
    );
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

//VALIDATE Forget Password
  bool validateOtp() {
    bool isValid = Validator().otpValidator(otp: otpController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //VALIDATE Create Profile
  bool validateProfile() {
    bool isValid = Validator().completeProfileValidator(
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

  // Save Login credentails if REMEMBER ME TRUE
  Future<void> saveIsLogin() async {
    await Getters.getLocalStorage.saveIsLogin(true);
  }

//DID YOU FORGOT YOUR PASSWORD
  Future<void> forgotPassword() async {
    state = const AuthApiLoading(authType: AuthType.forgotPassword);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.forgotPassword);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "email": emailController.text.trim(),
      };
      final result = await authUseCase.forgotPassword(body: body);
      state = result.fold((error) {
        log("forgot password error:${error.message} ");
        return AuthApiFailed(
            error: error.message, authType: AuthType.forgotPassword);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.forgotPassword);
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.forgotPassword);
    }
  }

// VERIFY OTP
  Future<void> verifyOtp() async {
    state = const AuthApiLoading(authType: AuthType.otpVerify);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.otpVerify);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "email": emailController.text.trim(),
        "otp": otpController.text.trim(),
      };
      final result = await authUseCase.otpVerify(body: body);
      state = result.fold((error) {
        log("verifyOtp error:${error.message} ");
        return AuthApiFailed(
            error: error.message, authType: AuthType.otpVerify);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.otpVerify);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.otpVerify);
    }
  }

// RESET PASSWORD
  Future<void> resetPassword() async {
    state = const AuthApiLoading(authType: AuthType.resetPassword);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.resetPassword);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "email": emailController.text.trim(),
        "password": pswdController.text.trim(),
      };
      final result = await authUseCase.resetPassword(body: body);
      state = result.fold((error) {
        log("resetPassword error:${error.message} ");
        return AuthApiFailed(
            error: error.message, authType: AuthType.resetPassword);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.resetPassword);
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.resetPassword);
    }
  }
}

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

// //LOGIN
//   Future<void> login() async {
//     state = const AuthApiLoading(authType: AuthType.login);
//     try {
//       if (!(await Getters.networkInfo.isConnected)) {
//         state = const AuthApiFailed(
//             error: "No internet connection", authType: AuthType.login);
//         return;
//       }
//       if (await Getters.networkInfo.isSlow) {}
//       Map<String, dynamic> body = {
//         "email": "dev@yopmail.com",
//         "password": "Pass@123",
//         "device_type": "android",
//         "device_token": "No Token",
//       };
//       final result = await authUseCase.callLogin(body: body);
//       state = result.fold((error) {
//         return AuthApiFailed(error: error.message, authType: AuthType.login);
//       }, (result) {
//         return const AuthApiSuccess(authType: AuthType.login);
//       });
//     } catch (e) {
//       state = AuthApiFailed(error: e.toString(), authType: AuthType.login);
//     }
//   }

// //GET SOCIAL PROFILES
//   Future<void> getSocialPlatform() async {
//     state = const AuthApiLoading(authType: AuthType.socialMedia);
//     try {
//       if (!(await Getters.networkInfo.isConnected)) {
//         state = const AuthApiFailed(
//             error: "No internet connection", authType: AuthType.socialMedia);
//         return;
//       }

//       final result = await authUseCase.getPlatform();
//       state = result.fold((error) {
//         return AuthApiFailed(
//             error: error.message, authType: AuthType.socialMedia);
//       }, (result) {
//         log("result is:-> $result");

//         // Update the list and notify UI by updating state
//         platformDataList = result ?? [];
//         return const AuthApiSuccess(
//           authType: AuthType.socialMedia,
//         );
//       });
//     } catch (e) {
//       state =
//           AuthApiFailed(error: e.toString(), authType: AuthType.socialMedia);
//     }
//   }
}

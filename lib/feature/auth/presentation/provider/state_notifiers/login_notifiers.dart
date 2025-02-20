import 'dart:developer';
import 'dart:io';
import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/feature/auth/data/models/user_model.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      String token = await FirebaseMessaging.instance.getToken() ?? '';

      log("fcm token is :-> $token");
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
        "device_token": token,
      };
      final result = await authUseCase.callLogin(body: body, isSocial: false);
      state = result.fold((error) {
        log("login error:${error.message} ");

        return AuthApiFailed(error: error.message, authType: AuthType.login);
      }, (result) {
        clearLoginFields();
        return const AuthApiSuccess(authType: AuthType.login);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.login);
    }
  }

//CLEAR LOGIN FIELD

  Future<void> clearLoginFields() async {
    emailController.clear();
    passwordController.clear();
  }

// SIGN UP
  Future<void> signUpApi() async {
    state = const AuthApiLoading(authType: AuthType.signup);
    try {
      String token = await FirebaseMessaging.instance.getToken() ?? '';

      log("fcm token is :-> $token");
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection, authType: AuthType.signup);
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
        "device_token": token,
      };
      final result = await authUseCase.callLogin(body: body, isSocial: false);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return AuthApiFailed(error: error.message, authType: AuthType.signup);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.signup);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.signup);
    }
  }

//LOG OUT

  //LOGOUT API
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

  // //SOCIAL LOGIN

  Future<UserModel?> signInWithGoogle(BuildContext context) async {
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection, authType: AuthType.login);
      }
      if (await Getters.networkInfo.isSlow) {}
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
      final result = await googleSignIn.signIn();
      if (result != null) {
        final googleAuth = await result.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        log("social credential :-> $credential");
        return _signInWithCredential(credential,
            socialType: "google",
            userName: result.displayName,
            email: result.email);
      }
      return null;
    } catch (e, s) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.login);
      blocLog(
        msg: 'Google sign-in error: $e ,$s',
        bloc: "AuthServices1",
      );
      return null;
    }
  }

  Future<UserModel?> _signInWithCredential(OAuthCredential oauthCredential,
      {String? userName, String? email, required String socialType}) async {
    try {
      Utils.showLoader();
      final userCredential = await _signInWithFirebase(oauthCredential);

      // log("user credentails :-> ${userCredential?.user?.uid}");
      final authUser = userCredential?.user;
      if (authUser != null) {
        await socialLoginApi(
          socialId: authUser.uid,
          socialType: socialType,
        );
        // await _updateUserProfile(authUser, userName);
        // final updatedUser = FirebaseAuth.instance.currentUser;
        // Utils.hideLoader();
        // return _buildUserModel(
        //     updatedUser, authUser, email, socialType, userName);
      } else {
        Utils.hideLoader();
        return null;
      }
    } catch (e, s) {
      Utils.hideLoader();
      blocLog(
        msg: 'Sign-in with credential error: $e',
        bloc: "AuthServices2",
      );
      return null;
    }
    return null;
  }

  Future<UserCredential?> _signInWithFirebase(
      OAuthCredential oauthCredential) async {
    try {
      return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e, s) {
      blocLog(
        msg: 'Firebase sign-in error: $e',
        bloc: "AuthServices3",
      );
      rethrow;
    }
  }

  //LOGIN
  Future<void> socialLoginApi({
    required String socialId,
    required String socialType,
  }) async {
    state = const AuthApiLoading(authType: AuthType.login);
    try {
      String token = await FirebaseMessaging.instance.getToken() ?? '';
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
        "social_id": socialId.trim(),
        "social_type": socialType,
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_token": token,
      };
      final result = await authUseCase.callLogin(body: body, isSocial: true);
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
}

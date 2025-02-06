import 'dart:developer';

import 'package:NearMii/config/enums.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/helpers/all_getter.dart';
import '../../../domain/usecases/get_auth.dart';
import '../states/auth_states.dart';

class LoginNotifier extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final phoneController =
      TextEditingController(text: kDebugMode ? "9876543210" : "");
  final otpController = TextEditingController(text: kDebugMode ? "1234" : "");
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final referralController = TextEditingController();

  List<PlatformData> platformDataList = [];

  LoginNotifier({required this.authUseCase}) : super(AuthInitial());

//LOGIN
  Future<void> login() async {
    state = const AuthApiLoading(authType: AuthType.login);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: "No internet connection", authType: AuthType.login);
        return;
      }
      if (await Getters.networkInfo.isSlow) {}
      Map<String, dynamic> body = {
        "email": "dev@yopmail.com",
        "password": "Pass@123",
        "device_type": "android",
        "device_token": "No Token",
      };
      final result = await authUseCase.callLogin(body: body);
      state = result.fold((error) {
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

        // Update the list and notify UI by updating state
        platformDataList = result ?? [];
        return const AuthApiSuccess(
          authType: AuthType.socialMedia,
        );
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.socialMedia);
    }
  }
}

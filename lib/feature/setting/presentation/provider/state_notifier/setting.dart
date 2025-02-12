import 'package:NearMii/config/validator.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/auth/domain/usecases/get_auth.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingNotifier extends StateNotifier<AuthState> {
  final AuthUseCase authUseCase;
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final referralController = TextEditingController();
  final dobController = TextEditingController();
  final bioController = TextEditingController();
  final currentPasswordController = TextEditingController();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final designationController = TextEditingController();

  final genderController = TextEditingController();

  List<PlatformData> platformDataList = [];

  SettingNotifier({required this.authUseCase}) : super(AuthInitial());

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
}

import 'package:NearMii/config/app_utils.dart';

import 'helper.dart';

class Validator {
  static final Validator _singleton = Validator._internal();

  factory Validator() {
    return _singleton;
  }

  Validator._internal();

  static Validator get instance => _singleton;

  var error = "";
//sign up
  bool signUpValidator({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (email.isEmpty) {
      error = AppString.pleaseEnterEmailAddress;
      return false;
    } else if (!Utils.emailValidation(email)) {
      error = AppString.pleaseEnterValidEmailAddress;
      return false;
    } else if (password.isEmpty) {
      error = AppString.pleaseEnterPassword;
      return false;
    } else if (checkPassword(password)) {
      error = AppString.passwordShouldBe;
      return false;
    } else if (confirmPassword.isEmpty) {
      error = AppString.pleaseEnterConfirmPassword;
      return false;
    } else if (password != confirmPassword) {
      error = AppString.passwordMismatch;
      return false;
    }
    return true;
  }

// cpmplete profile
  bool completeProfileValidator({
    required String phoneNumber,
    required String fullName,
    required String dob,
    required String designation,
    required String gender,
  }) {
    if (fullName.isEmpty) {
      error = AppString.pleaseEnterName;
      return false;
    }
    if (designation.isEmpty) {
      error = AppString.pleaseEnterDesignation;
      return false;
    }

    if (phoneNumber.isEmpty) {
      error = AppString.validNumber;
      return false;
    } else if (phoneNumber.length < 6 || phoneNumber.length > 12) {
      error = AppString.validPhoneNumber;
      return false;
    }
    if (gender.isEmpty) {
      error = AppString.pleaseEnterGender;
      return false;
    }

    if (dob.isEmpty) {
      error = AppString.pleaseEnterDob;
      return false;
    }

    return true;
  }

  // login
  bool loginValidator({
    required String email,
    required String password,
  }) {
    if (email.isEmpty) {
      error = AppString.pleaseEnterEmailAddress;
      return false;
    } else if (!Utils.emailValidation(email)) {
      error = AppString.pleaseEnterValidEmailAddress;
      return false;
    }

    if (password.isEmpty) {
      error = AppString.pleaseEnterPassword;
      return false;
    } else if (checkPassword(password)) {
      error = AppString.passwordShouldBe;
      return false;
    }

    return true;
  }

  // forget Password
  bool forgetPasswordValidator({
    required String email,
  }) {
    if (email.isEmpty) {
      error = AppString.pleaseEnterEmailAddress;
      return false;
    } else if (!Utils.emailValidation(email)) {
      error = AppString.pleaseEnterValidEmailAddress;
      return false;
    }

    return true;
  }

//otp
  bool otpValidator({
    required String otp,
  }) {
    if (otp.isEmpty) {
      error = AppString.pleaseEnterOtp;
      return false;
    } else if (otp.length != 4) {
      error = AppString.invalidOtp;
      return false;
    }

    return true;
  }

  //Create New Password
  bool createNewPasswordValidation({
    required String password,
    required String confirmPassword,
  }) {
    if (password.isEmpty) {
      error = AppString.pleaseEnterPassword;
      return false;
    } else if (checkPassword(password)) {
      error = AppString.passwordShouldBe;
      return false;
    } else if (confirmPassword.isEmpty) {
      error = AppString.pleaseEnterConfirmPassword;
      return false;
    } else if (password != confirmPassword) {
      error = AppString.passwordMismatch;
      return false;
    }
    return true;
  }

  bool checkPassword(String password) {
    return ((password.trim().length < 8) ||
        (!RegExp(r'(?=.*?\d)').hasMatch(password.trim())) ||
        (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password.trim())));
  }

// cpmplete Edit profile
  bool completeEditProfileValidator({
    required String phoneNumber,
    required String fullName,
    required String dob,
    required String designation,
    required String gender,
  }) {
    if (fullName.isEmpty) {
      error = AppString.pleaseEnterName;
      return false;
    }
    if (designation.isEmpty) {
      error = AppString.pleaseEnterDesignation;
      return false;
    }

    if (phoneNumber.isEmpty) {
      error = AppString.validNumber;
      return false;
    } else if (phoneNumber.length < 6 || phoneNumber.length > 12) {
      error = AppString.validPhoneNumber;
      return false;
    }
    if (gender.isEmpty) {
      error = AppString.pleaseEnterGender;
      return false;
    }

    if (dob.isEmpty) {
      error = AppString.pleaseEnterDob;
      return false;
    }

    return true;
  }

  //Change Password
  bool changePasswordValidation({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    if (currentPassword.isEmpty) {
      error = AppString.pleaseEnterCurrentPassword;
      return false;
    }
    //  else if (currentPassword != storedPassword) {
    //   error = AppString.incorrectCurrentPassword;
    //   return false;
    // }
    else if (newPassword.isEmpty) {
      error = AppString.pleaseEnterNewPassword;
      return false;
    } else if (newPassword == currentPassword) {
      error = AppString.newPasswordShouldBeDifferent;
      return false;
    } else if (checkPassword(newPassword)) {
      error = AppString.newPasswordShouldBe;
      return false;
    } else if (confirmPassword.isEmpty) {
      error = AppString.pleaseEnterConfirmPassword;
      return false;
    } else if (newPassword != confirmPassword) {
      error = AppString.passwordMismatch;
      return false;
    }
    return true;
  }
}

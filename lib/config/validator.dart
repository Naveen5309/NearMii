import 'dart:developer';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/countries.dart';

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
    log("email entered is :-> $email");
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

  bool validatePhoneNumber({
    required String phoneNumber,
    required String countryCode,
  }) {
    printLog("Phone phoneNumber length: ->10 $phoneNumber");
    printLog("Phone countryCode length: ->15 $countryCode");

    if (phoneNumber.isEmpty) {
      error = AppString.validNumber;
      return false;
    }

    // Trim and clean the phone number of spaces or special characters
    phoneNumber =
        phoneNumber.replaceAll(RegExp(r'\D'), ''); // Removes non-digits

    // Find the selected country based on the countryCode
    Country? selectedCountry = allCountries.firstWhere(
      (country) => country.dialCode == countryCode,
      orElse: () => const Country(name: "Unknown"),
    );

    if (selectedCountry.minLength != null &&
        selectedCountry.maxLength != null &&
        (phoneNumber.length < selectedCountry.minLength! ||
            phoneNumber.length > selectedCountry.maxLength!)) {
      error =
          "Phone number must be exactly ${selectedCountry.minLength} digits for ${selectedCountry.name}";
      // "invalid phone number";
      return false;
    }

    return true;
  }

// cpmplete profile
  bool completeProfileValidator({
    required String phoneNumber,
    required String fullName,
    required String countryCode,
  }) {
    printLog("Phone phoneNumber length: ->10 $phoneNumber");
    printLog("Phone countryCode length: ->15 $countryCode");

    if (fullName.isEmpty) {
      error = AppString.pleaseEnterName;
      return false;
    }

    if (phoneNumber.isEmpty) {
      error = AppString.validNumber;
      return false;
    }

    // Trim and clean the phone number of spaces or special characters
    phoneNumber =
        phoneNumber.replaceAll(RegExp(r'\D'), ''); // Removes non-digits

    // Find the selected country based on the countryCode
    Country? selectedCountry = allCountries.firstWhere(
      (country) => country.dialCode == countryCode,
      orElse: () => const Country(name: "Unknown"),
    );

    if (selectedCountry.minLength != null &&
        selectedCountry.maxLength != null &&
        (phoneNumber.length < selectedCountry.minLength! ||
            phoneNumber.length > selectedCountry.maxLength!)) {
      error =
          "Phone number must be exactly ${selectedCountry.minLength} digits for ${selectedCountry.name}";
      // "invalid phone number";
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
    }
    // else if (checkPassword(password)) {
    //   error = AppString.passwordShouldBe;
    //   return false;
    // }

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

  //otp
  bool addPlatformValidator({
    required String url,
    required String type,
  }) {
    if (url.isEmpty) {
      error = AppString.fieldCantEmpty;
      return false;
    }

    if (type.trim() == "Enter URL") {
      final urlPattern = RegExp(
          r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');
      if (!urlPattern.hasMatch(url)) {
        error = "invalid url";
        return false;
      }
    } else if (type.trim() == "Enter email address") {
      final emailPattern =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailPattern.hasMatch(url)) {
        error = "invalid email";
        return false;
      }
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
  }) {
    if (fullName.isEmpty) {
      error = AppString.pleaseEnterName;
      return false;
    }

    if (phoneNumber.isEmpty) {
      error = AppString.validNumber;
      return false;
    } else if (phoneNumber.length < 6 || phoneNumber.length > 12) {
      error = AppString.validPhoneNumber;
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

  //  Contact us
  bool contactUsValidator({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) {
    if (name.isEmpty) {
      error = AppString.pleaseEnterName;
      return false;
    } else if (email.isEmpty) {
      error = AppString.pleaseEnterEmail;
      return false;
    } else if (!Utils.emailValidation(email)) {
      error = AppString.pleaseEnterValidEmailAddress;
      return false;
    } else if (subject.isEmpty) {
      error = AppString.pleaseEnterSubject;
      return false;
    } else if (message.isEmpty) {
      error = AppString.pleaseEnterMessage;
      return false;
    }

    return true;
  }

  //Delete Account
  bool deleteAccountValidation({
    required String currentPassword,
    // required String reason,
  }) {
    // if (reason.isEmpty) {
    //   error = AppString.selectReason;
    //   return false;
    // } else
    if (currentPassword.isEmpty) {
      error = AppString.pleaseEnterCurrentPassword;
      return false;
    }

    return true;
  }

  //Delete Account
  bool deleteAccountValidationSocial({
    required String reason,
  }) {
    if (reason.isEmpty) {
      error = AppString.selectReason;
      return false;
    }
    return true;
  }
}

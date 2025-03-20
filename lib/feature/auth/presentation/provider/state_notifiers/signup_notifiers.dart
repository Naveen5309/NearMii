import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:NearMii/config/countries.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/config/validator.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/auth/data/models/new_get_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/new_other_user_social_platform.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final searchTextController = TextEditingController();
  String countryCode = '+1';
  String countryNameCode = 'US';
  int maxLength = 10;

  String countryFlag = '🇺🇸';
  String profilePic = '';
  String name = '';
  String socialImage = '';
  String socialEmail = '';

  final urlController = TextEditingController();

  final designationController = TextEditingController();

  final genderController = TextEditingController();

  //My Profile Method to upload profile image
  XFile? image;
  String imageUrl = '';

  String socialId = '';

  List<PlatformCatagory> newPlatformLists = [];

  List<int> selectedPlatform = [];

  SignupNotifiers({required this.authUseCase}) : super(AuthInitial());

  int secondsRemaining = 30;
  bool enableResend = false;

  bool isSocialLoading = true;

  Timer? timer;

  void startTimer() {
    // resendOtpApi();
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        enableResend = false;
        secondsRemaining--;
        if (secondsRemaining == 0) {
          timer?.cancel();
          enableResend = true;
          secondsRemaining = 30;
        }
        state = UpdateTimer();
      } else {
        enableResend = true;
        state = UpdateTimer();
      }
    });
  }

  Future<void> cancelTimer() async {
    timer?.cancel();
    enableResend = true;
    secondsRemaining = 30;
  }

  updateSocialData({
    required String img,
    required String name,
    required String email,
  }) {
    printLog("update social data called:> $img ,$name");
    fullNameController.text = name;

    socialImage = img;
    socialEmail = email;
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

  //VALIDATE ADD PLATFORM
  bool validateAddPlatform() {
    bool isValid =
        Validator().addPlatformValidator(url: urlController.text.trim());
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

//GET SOCIAL PROFILES
  Future<void> getSocialPlatform() async {
    state = const AuthApiLoading(authType: AuthType.socialMedia);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: "No internet connection", authType: AuthType.socialMedia);
        return;
      }
      Map<String, dynamic> body = {
        "search": searchTextController.text.trim(),
      };

      final result = await authUseCase.getPlatform(body: body);
      state = result.fold((error) {
        return AuthApiFailed(
            error: error.message, authType: AuthType.socialMedia);
      }, (result) {
        log("social media result is:->1 $result");

        newPlatformLists = result;

        newPlatformLists = newPlatformLists
            .where((platformCatagory) =>
                platformCatagory.list != null &&
                platformCatagory.list!.isNotEmpty)
            .toList();

        log("social media result is:->1 platfomlist $result");

        // Convert "data" into a list containing its key-value pairs

        // Wrap the transformed list inside a new "data" key
        // Map<String, dynamic> newData = {"data": transformedData};

        // log("social media result is:->2 $platformLists");

        // socialMediaList = result.socialMedia ?? [];
        // portfolioList = result.portfolio ?? [];
        // contactList = result.contactInformation ?? [];

        // log("result is 15:-> $socialMediaList");

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

//GET SOCIAL PROFILES
  Future<void> getAddNewSocialPlatform({
    required List<SelfPlatformCatagoryData> myPlatformList,
  }) async {
    state = const AuthApiLoading(authType: AuthType.socialMedia);
    isSocialLoading = true;
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: "No internet connection", authType: AuthType.socialMedia);
        return;
      }
      Map<String, dynamic> body = {
        "search": searchTextController.text.trim(),
      };

      final result = await authUseCase.getPlatform(body: body);
      state = result.fold((error) {
        isSocialLoading = false;
        return AuthApiFailed(
            error: error.message, authType: AuthType.socialMedia);
      }, (result) {
        log("result is:-> $result");

        log("social media result is:->1 $result");

        newPlatformLists = result;

        newPlatformLists = newPlatformLists
            .where((platformCatagory) =>
                platformCatagory.list != null &&
                platformCatagory.list!.isNotEmpty)
            .toList();

        for (var platformCategory in newPlatformLists) {
          platformCategory.list?.removeWhere((platformData) {
            bool isMatched = myPlatformList.any((myPlatform) {
              return myPlatform.list?.any((data) {
                    printLog(
                        "Comparing platformData.id: ${platformData.id} with data.id: ${data.platformId}");

                    printLog(
                        "matched data :-> ${data.platformId == platformData.id}");
                    return data.platformId == platformData.id;
                  }) ??
                  false;
            });

            if (isMatched) {
              printLog("Removing platformData with id: ${platformData.id}");
            }

            return isMatched;
          });
        }
        newPlatformLists = newPlatformLists
            .where((platformCatagory) =>
                platformCatagory.list != null &&
                platformCatagory.list!.isNotEmpty)
            .toList();
        isSocialLoading = false;

        return const AuthApiSuccess(
          authType: AuthType.socialMedia,
        );
      });
    } catch (e) {
      isSocialLoading = false;

      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.socialMedia);
    }
  }

//DID YOU FORGOT YOUR PASSWORD
  Future<void> forgotPasswordApi({required AuthType authType}) async {
    state = AuthApiLoading(authType: authType);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = AuthApiFailed(
            error: AppString.noInternetConnection, authType: authType);
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
        return AuthApiFailed(error: error.message, authType: authType);
      }, (result) {
        enableResend = false;
        secondsRemaining = 30;
        return AuthApiSuccess(authType: authType);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: authType);
    }
  }

// ADD PLATFORM
  Future<void> addPlatform({
    required String platformId,
    required bool isPhone,
  }) async {
    state = const AuthApiLoading(authType: AuthType.addPlatform);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.addPlatform);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "platform_id": platformId,
        "url": isPhone
            ? "$countryCode ${urlController.text.trim()}"
            : urlController.text.trim(),
      };
      final result = await authUseCase.addPlatformApi(body: body);
      state = result.fold((error) {
        log("forgot password error:${error.message} ");
        return AuthApiFailed(
            error: error.message, authType: AuthType.addPlatform);
      }, (result) {
        selectedPlatform.add(int.parse(platformId));
        selectedPlatform = selectedPlatform.toSet().toList();
        urlController.clear();
        return const AuthApiSuccess(authType: AuthType.addPlatform);
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.addPlatform);
    }
  }

//COMPLETE PROFILE API
  Future<void> completeProfileApi() async {
    state = const AuthApiLoading(authType: AuthType.completeProfile);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.completeProfile);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "name": fullNameController.text.trim(),
        "designation": designationController.text.trim(),
        "phone_number": "$countryCode ${phoneController.text.trim()}",
        "gender": genderController.text.trim(),
        "country_code": countryNameCode,
        "dob": dobController.text.isNotEmpty
            ? DateFormat("yyyy/MM/dd").format(
                DateFormat("MM/dd/yyyy").parse(dobController.text.trim()))
            : '',
        "token": referralController.text.trim(),
        "bio": bioController.text.trim(),
        "social_image": socialImage,
        if (socialEmail.isNotEmpty) "email": socialEmail
      };
      final result = await authUseCase.completeProfile(
          body: body, imagePath: image?.path ?? '');
      state = result.fold((error) {
        log("forgot password error:${error.message} ");
        return AuthApiFailed(
            error: error.message, authType: AuthType.completeProfile);
      }, (result) {
        enableResend = false;
        profilePic = result.profilePhoto ?? '';
        name = result.name ?? '';

        saveToLocalStorage();

        return const AuthApiSuccess(authType: AuthType.completeProfile);
      });
    } catch (e) {
      state = AuthApiFailed(
          error: e.toString(), authType: AuthType.completeProfile);
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

  //VALIDATE Edit Profile
  bool validateEditProfile() {
    bool isValid = Validator().completeEditProfileValidator(
        fullName: fullNameController.text.trim(),
        phoneNumber: phoneController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
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

  //VALIDATE Forget Password
  bool validateForgetPassword() {
    bool isValid =
        Validator().forgetPasswordValidator(email: emailController.text.trim());
    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

  //VALIDATE RESET Password
  bool validateResetPassword() {
    bool isValid = Validator().createNewPasswordValidation(
        password: pswdController.text.trim(),
        confirmPassword: confirmPswdController.text.trim());

    if (isValid) {
      return true;
    } else {
      toast(msg: Validator().error, isError: true);
      return false;
    }
  }

//LOGIN
  Future<void> registerApi() async {
    state = const AuthApiLoading(authType: AuthType.signup);
    try {
      String token = await FirebaseMessaging.instance.getToken() ?? '';

      // log("fcm token is :-> $token");
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
        "password": pswdController.text.trim(),
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_token": token,
      };
      final result = await authUseCase.signUp(
        body: body,
      );
      state = result.fold((error) {
        log("login error:${error.message} ");
        return AuthApiFailed(error: error.message, authType: AuthType.signup);
      }, (result) {
        clearSignUpFields();
        return const AuthApiSuccess(authType: AuthType.signup);
      });
    } catch (e) {
      state = AuthApiFailed(error: e.toString(), authType: AuthType.signup);
    }
  }

  //UPLOAD IMAGE

  Future<void> pickAndCropImage(
      {required ImageSource source, required BuildContext context}) async {
    try {
      XFile? file = await ImagePicker().pickImage(source: source);
      if (file != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: AppColor.green009E51,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            IOSUiSettings(
              title: 'Cropper',
            ),
          ],
        );
// Handle the cropped file if not null
        if (croppedFile != null) {
          image = XFile(croppedFile.path); // Store the cropped file

          state = PickImageState();

          if (kDebugMode) {
            print("Cropped image path: ${croppedFile.path} $state");
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        } else {
          throw Exception("Image cropping failed");
        }
      } else {
        throw Exception("No image selected");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  clearSignUpFields() {
    emailController.clear();
    pswdController.clear();
    confirmPswdController.clear();
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

  clearOtpFields() {
    otpController.clear();
  }

  clearResetPasswordFields() {
    pswdController.clear();
    confirmPswdController.clear();
  }

// RESET PASSWORD
  Future<void> changePasswordApi({required AuthType authType}) async {
    state = const AuthApiLoading(authType: AuthType.changePassword);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.changePassword);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "current_password": currentPasswordController.text.trim(),
        "new_password": newPasswordController.text.trim(),
      };
      final result = await authUseCase.changePassword(body: body);
      state = result.fold((error) {
        log("changePassword error:${error.message} ");
        return AuthApiFailed(
            error: error.message, authType: AuthType.changePassword);
      }, (result) {
        return const AuthApiSuccess(authType: AuthType.changePassword);
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.changePassword);
    }
  }

//update PROFILE API
  Future<void> editProfileApi(Country county) async {
    state = const AuthApiLoading(authType: AuthType.editProfile);
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const AuthApiFailed(
            error: AppString.noInternetConnection,
            authType: AuthType.editProfile);
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }

      log("dob ius :-> ${dobController.text}");
      final Map<String, String> body = {
        "name": fullNameController.text.trim(),
        if (socialId.isNotEmpty) "social_id": socialId,
        if (socialId.isNotEmpty) "social_type": 'google',
        "designation": designationController.text.trim(),
        "phone_number": "${county.dialCode} ${phoneController.text.trim()}",
        "bio": bioController.text.trim(),
        "gender": genderController.text.trim(),
        "dob": formatDOBforUpdate(
          dobController.text.trim(),
        ),
      };

      final result = await authUseCase.editProfile(
          body: body, imagePath: image?.path ?? '');

      state = result.fold((error) {
        log("edit Profile error: ${error.message}");
        return AuthApiFailed(
            error: error.message, authType: AuthType.editProfile);
      }, (result) {
        printLog(result);
        return const AuthApiSuccess(authType: AuthType.editProfile);
      });
    } catch (e) {
      state =
          AuthApiFailed(error: e.toString(), authType: AuthType.editProfile);
    }
  }

  Future<void> setDatainFields() async {
    UserProfileModel? getProfile = Getters.getLocalStorage.getUserProfileData();

    fullNameController.text = getProfile?.name ?? '';
    designationController.text = getProfile?.designation ?? '';
    phoneController.text = (getProfile?.phoneNumber).toString().split(' ').last;
    dobController.text = formatDob(getProfile?.dob ?? '');
    genderController.text = getProfile?.gender ?? '';
    bioController.text = getProfile?.bio ?? '';
    imageUrl = getProfile?.profilePhoto ?? '';
    socialImage = getProfile?.socialImage ?? '';

    socialId = getProfile?.socialId ?? '';
    countryCode = (getProfile?.phoneNumber).toString().split(' ').first;
    countryFlag = getFlagByDialCode(
            (getProfile?.phoneNumber).toString().split(' ').first) ??
        '🇺🇸';

    printLog("social img is :-> ${getProfile?.socialId}");
    printLog("social img is :-> ${getProfile?.name}");
    printLog("social img is :-> ${getProfile?.socialImage}");
  }

  void saveToLocalStorage() async {
    await Getters.getLocalStorage.saveName(name);
    await Getters.getLocalStorage.saveProfileImg(profilePic);
    await Getters.getLocalStorage.saveSocialImg(socialImage);
  }

  clearFormFields() {
    emailController.clear();
    pswdController.clear();
    confirmPswdController.clear();
  }

  void updateCountryData(
      {required String dialCode,
      required String countryNmCode,
      required int maLength}) async {
    log("update code called");
    state = UpdateCodeLoading();
    countryCode = dialCode;
    countryNameCode = countryNmCode;
    maxLength = maLength;

    state = UpdateCodeLoaded();

    log("update code called :-> $countryCode, $countryFlag, $countryNameCode, $maLength");
  }
}

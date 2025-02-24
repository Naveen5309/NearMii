import 'dart:developer';

import 'package:NearMii/feature/auth/data/models/add_platform_response_model.dart';
import 'package:NearMii/feature/auth/data/models/complete_profile_response_model.dart';
import 'package:NearMii/feature/auth/data/models/edit_profile_model.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/user_register_response_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';
import '../models/user_model.dart';

abstract class AuthDataSource {
  Future<ResponseWrapper?> logInUser(
      {required Map<String, dynamic> body, required bool isSocial});

  Future<ResponseWrapper?> signUpApi({required Map<String, dynamic> body});
  Future<ResponseWrapper?> addPlatform({required Map<String, dynamic> body});
  Future<ResponseWrapper?> forgotPassword({required Map<String, dynamic> body});

  Future<ResponseWrapper?> completeProfile(
      {required Map<String, dynamic> body, required String imagePath});

  Future<ResponseWrapper?> otpVerify({required Map<String, dynamic> body});
  Future<ResponseWrapper?> resetPassword({required Map<String, dynamic> body});

  Future<ResponseWrapper?> getPlatformApi();
  Future<ResponseWrapper?> logOutApi();
  Future<ResponseWrapper?> changePassword({required Map<String, dynamic> body});
  Future<ResponseWrapper?> editProfile(
      {required Map<String, dynamic> body, required String imagePath});
}

class AuthDataSourceImpl extends AuthDataSource {
//LOGIN API
  @override
  Future<ResponseWrapper<UserModel>?> logInUser({
    required Map<String, dynamic> body,
    required bool isSocial,
  }) async {
    try {
      final dataResponse = await Getters.getHttpService.request<UserModel>(
          body: body,
          url: isSocial ? ApiConstants.socialLogin : ApiConstants.login,
          fromJson: (json) {
            log("json in data source :-> $json");

            // Ensure the response is a map and correctly map it to GetPlatformData
            if (json is Map<String, dynamic>) {
              return UserModel.fromJson(json["data"]);
            }
            throw Exception("Unexpected API response format");
          });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");
        UserModel model = dataResponse.data!;
        log("user data is:-> $model");
        log("user data is:-> ${dataResponse.token}");
        log("user data is:-> $dataResponse");

        if (model.isProfile == 1) {
          await Getters.getLocalStorage.saveLoginUser(model);
          await Getters.getLocalStorage.saveIsLogin(true);
          await Getters.getLocalStorage.saveToken(dataResponse.token ?? "");
        } else {
          await Getters.getLocalStorage.saveToken(dataResponse.token ?? "");
        }

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "userLogin",
      ));
    }
  }

//SIGN UP API
  @override
  Future<ResponseWrapper<UserRegisterData>?> signUpApi({
    required Map<String, dynamic> body,
  }) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<UserRegisterData>(
              body: body,
              url: ApiConstants.register,
              fromJson: (json) {
                log("json in data source :-> $json");

                // Ensure the response is a map and correctly map it to GetPlatformData
                if (json is Map<String, dynamic>) {
                  return UserRegisterData.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");
        UserRegisterData model = dataResponse.data!;
        log("user data is:-> $model");
        log("user data is:-> ${dataResponse.token}");
        log("user data is:-> $dataResponse");

        await Getters.getLocalStorage.saveToken(dataResponse.token ?? "");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "signUpApi",
      ));
    }
  }

//FORGOT PASSWORD API
  @override
  Future<ResponseWrapper<dynamic>?> forgotPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.forgetPassword,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;

            // Ensure the response is a map and correctly map it to GetPlatformData
            // if (json is Map<String, dynamic>) {
            //   return UserModel.fromJson(json["data"]);
            // }
            // throw Exception("Unexpected API response format");
          });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "forgotPassword",
      ));
    }
  }

//FORGOT PASSWORD API
  @override
  Future<ResponseWrapper<dynamic>?> addPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<AddPlatformData>(
              body: body,
              url: ApiConstants.addPlatform,
              fromJson: (json) {
                log("json in data source :-> $json");

                if (json is Map<String, dynamic>) {
                  return AddPlatformData.fromJson(json["data"]);
                }

                return json;
              });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "forgotPassword",
      ));
    }
  }

//complete Profile  API
  @override
  Future<ResponseWrapper<dynamic>?> completeProfile({
    required Map<String, dynamic> body,
    required String imagePath,
  }) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<CompleteProfileData>(
              body: body,
              imagePath: imagePath,
              paramName: "profile_photo",
              url: ApiConstants.completeProfile,
              fromJson: (json) {
                log("json in data source :-> $json");

                // Ensure the response is a map and correctly map it to GetPlatformData
                if (json is Map<String, dynamic>) {
                  return CompleteProfileData.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "completeProfile",
      ));
    }
  }

//OTP VERIFY API
  @override
  Future<ResponseWrapper<dynamic>?> otpVerify(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.verifyOtp,
          fromJson: (json) {
            log("json in data source :-> $json");
            return json;

            // // Ensure the response is a map and correctly map it to GetPlatformData
            // if (json is Map<String, dynamic>) {
            //   return UserModel.fromJson(json["data"]);
            // }
            // throw Exception("Unexpected API response format");
          });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "otpVerify",
      ));
    }
  }

//RESET PASSWORD
  @override
  Future<ResponseWrapper<dynamic>?> resetPassword(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.resetPassword,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;
          });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "resetPassword",
      ));
    }
  }

//RESET PASSWORD
  @override
  Future<ResponseWrapper<dynamic>?> changePassword(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.changePassword,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;
          });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "resetPassword",
      ));
    }
  }

//GET PLATFORM
  @override
  Future<ResponseWrapper<GetPlatformData>> getPlatformApi() async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<GetPlatformData>(
              url: ApiConstants.getPlatform,
              fromJson: (json) {
                log("json in data source :-> $json");

                // Ensure the response is a map and correctly map it to GetPlatformData
                if (json is Map<String, dynamic>) {
                  return GetPlatformData.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              },
              requestType: RequestType.post);

      if (dataResponse.status == "success") {
        log("success called");
        return getSuccessResponseWrapper(dataResponse);
      } else {
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      log("error called in get platform api");
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "getPlatformApi",
      ));
    }
  }

//  --->> LOGOUT  API<<---
  @override
  Future<ResponseWrapper<dynamic>> logOutApi() async {
    var token = Getters.getLocalStorage.getToken();

    log("token :$token");
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          url: ApiConstants.logout,
          fromJson: (json) {
            log("json in data source :-> $json");
          },
          requestType: RequestType.post);

      if (dataResponse.status == "success") {
        await Getters.getLocalStorage.clearAllBox();
        log("success called");
        return getSuccessResponseWrapper(dataResponse);
      } else {
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      log("error called in get logOutApi api");
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "logOutApi",
      ));
    }
  }

//edit Profile  API
  @override
  Future<ResponseWrapper<EditProfileModel>?> editProfile({
    required Map<String, dynamic> body,
    required String imagePath,
  }) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<EditProfileModel>(
              body: body,
              imagePath: imagePath,
              paramName: "profile_photo",
              url: ApiConstants.updateProfile,
              fromJson: (json) {
                log("json in data source :-> $json");

                // Ensure the response is a map and correctly map it to GetPlatformData
                if (json is Map<String, dynamic>) {
                  return EditProfileModel.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });

      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");

        return getSuccessResponseWrapper(dataResponse);
      } else {
        log("else called: ${dataResponse.message} ");
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "completeProfile",
      ));
    }
  }
}

import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SettingDataSource {
  Future<ResponseWrapper?> contactUS({required Map<String, dynamic> body});
  Future<ResponseWrapper?> radius({required Map<String, dynamic> body});
  Future<ResponseWrapper?> profileSummary({required Map<String, dynamic> body});
  Future<ResponseWrapper?> getProfile({required Map<String, dynamic> body});

  Future<ResponseWrapper?> deleteAccount({required Map<String, dynamic> body});
}

class SettingDataSourceImpl extends SettingDataSource {
  @override
  Future<ResponseWrapper<dynamic>?> contactUS(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.contactus,
          fromJson: (json) {
            log("json in data source :-> $json");
            return json["data"];
          });
      printLog("dataResponse===>$dataResponse");
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
        functionName: "userLogin",
      ));
    }
  }

  @override
  Future<ResponseWrapper<dynamic>?> deleteAccount(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.deleteAccount,
          fromJson: (json) {
            log("json in data source :-> $json");
            return json["data"];
          });
      printLog("dataResponse===>$dataResponse");
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
        functionName: "userLogin",
      ));
    }
  }

  @override
  Future<ResponseWrapper<dynamic>?> radius(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.deleteAccount,
          fromJson: (json) {
            log("json in data source :-> $json");
            return json["data"];
          });
      printLog("dataResponse===>$dataResponse");
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
        functionName: "userLogin",
      ));
    }
  }

  @override
  Future<ResponseWrapper<dynamic>?> profileSummary(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.contactus,
          fromJson: (json) {
            log("json in data source :-> $json");
            return json["data"];
          });
      printLog("dataResponse===>$dataResponse");
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
        functionName: "userLogin",
      ));
    }
  }

  @override
  Future<ResponseWrapper<UserProfileModel>?> getProfile(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<UserProfileModel>(
              requestType: RequestType.get,
              url: ApiConstants.getSelfProfile,
              fromJson: (json) {
                log("json in data source :-> $json");
                if (json is Map<String, dynamic>) {
                  return UserProfileModel.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });
      printLog("dataResponse===>$dataResponse");
      if (dataResponse.status == "success") {
        UserProfileModel model = dataResponse.data!;

        log("user data is:-> ${model.toJson()}");
        await Getters.getLocalStorage.saveGetUserProfile(model);

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
}

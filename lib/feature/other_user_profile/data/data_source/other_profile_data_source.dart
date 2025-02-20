import 'dart:developer';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/other_user_profile/data/model/other_user_profile_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class OtherUserProfileDataSource {
  Future<ResponseWrapper?> otherUserProfile(
      {required Map<String, dynamic> body});
  Future<ResponseWrapper?> getPlatformApi();
  Future<ResponseWrapper?> getReport({required Map<String, dynamic> body});
}

class OtherUserProfileDataSourceImpl extends OtherUserProfileDataSource {
  @override
  Future<ResponseWrapper<OtherUserProfileModel>?> otherUserProfile(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<OtherUserProfileModel>(
              body: body,
              url: ApiConstants.otherUserProfile,
              fromJson: (json) {
                log("json in data source :-> $json");

                if (json is Map<String, dynamic>) {
                  var myData = OtherUserProfileModel.fromJson(json["data"]);

                  log("mydata is :-. ${myData.name}");
                  return OtherUserProfileModel.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });
      print("dataResponse===>${dataResponse.data!.name}");
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
        functionName: "OtherUserProfileLogin",
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

  @override
  Future<ResponseWrapper<OtherUserProfileModel>?> getReport(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<OtherUserProfileModel>(
              body: body,
              url: ApiConstants.report,
              fromJson: (json) {
                log("json in data source :-> $json");

                if (json is Map<String, dynamic>) {
                  var myData = OtherUserProfileModel.fromJson(json["data"]);

                  log("mydata is :-. ${myData.name}");
                  return OtherUserProfileModel.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });
      print("dataResponse===>${dataResponse.data!.name}");
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
        functionName: "OtherUserProfileLogin",
      ));
    }
  }
}

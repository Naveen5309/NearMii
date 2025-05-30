import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/data/models/new_other_user_social_platform.dart';

import 'package:NearMii/feature/setting/data/model/profile_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SelfUserProfileDataSource {
  Future<ResponseWrapper<dynamic>> updateSocialLink(
      {required Map<String, dynamic> body});
  Future<ResponseWrapper<dynamic>> hideAllLinks(
      {required Map<String, dynamic> body});

  Future<ResponseWrapper<dynamic>> hidePlatform(
      {required Map<String, dynamic> body});
  Future<ResponseWrapper> getSelfPlatform({required Map<String, dynamic> body});
  Future<ResponseWrapper<dynamic>> delete({required Map<String, dynamic> body});
  Future<ResponseWrapper<dynamic>> getSocialProfile(
      {required Map<String, dynamic> body});
}

class SelfUserProfileDataSourceImpl extends SelfUserProfileDataSource {
  @override
  Future<ResponseWrapper<dynamic>> updateSocialLink(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          requestType: RequestType.post,
          url: ApiConstants.updateSocialLink,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;
            // print("json in data source :-> $json");

            // if (json is Map<String, dynamic>) {
            //   var myData = List<HistoryModel>.from(
            //       json["data"].map((x) => HistoryModel.fromJson(x)));

            //   log("mydata is :-. $myData");
            //   return myData;
            // }
            // throw Exception("Unexpected API response format");
          });
      printLog("dataResponse===>${dataResponse.data}");
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
        functionName: "updateSocialLink",
      ));
    }
  }

  @override
  Future<ResponseWrapper<dynamic>> hideAllLinks(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          requestType: RequestType.post,
          url: ApiConstants.hideAllProfile,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;
          });
      printLog("dataResponse===>${dataResponse.data}");
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

  @override
  Future<ResponseWrapper<dynamic>> hidePlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          requestType: RequestType.post,
          url: ApiConstants.hidePlatform,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;
          });
      printLog("dataResponse===>${dataResponse.data}");
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
        functionName: "hidePlatform",
      ));
    }
  }

  @override
  Future<ResponseWrapper<List<SelfPlatformCatagoryData>>> getSelfPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<List<SelfPlatformCatagoryData>>(
        body: body,
        requestType: RequestType.post,
        url: ApiConstants.getSelfPlatform,
        fromJson: (json) {
          log("json in data source :-> $json");

          // Ensure the response is a map and corrsectly map it to MyPlatformDataList
          if (json is Map<String, dynamic> && json["data"] is List) {
            // Map the response data into a List<PlatformCatagory>
            return (json["data"] as List)
                .map((item) => SelfPlatformCatagoryData.fromJson(
                    item as Map<String, dynamic>))
                .toList();
          }
          throw Exception("Unexpected API response format");
        },
      );
      printLog("dataResponse===>${dataResponse.data}");
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
        functionName: "getSelfPlatform",
      ));
    }
  }

  @override
  Future<ResponseWrapper<dynamic>> delete(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          requestType: RequestType.post,
          url: ApiConstants.deletePlatform,
          fromJson: (json) {
            log("json in data source :-> $json");

            return json;
            // print("json in data source :-> $json");

            // if (json is Map<String, dynamic>) {
            //   var myData = List<HistoryModel>.from(
            //       json["data"].map((x) => HistoryModel.fromJson(x)));

            //   log("mydata is :-. $myData");
            //   return myData;
            // }
            // throw Exception("Unexpected API response format");
          });
      printLog("dataResponse===>${dataResponse.data}");
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
        functionName: "delete",
      ));
    }
  }

  @override
  Future<ResponseWrapper<dynamic>> getSocialProfile(
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

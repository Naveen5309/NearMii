import 'dart:developer';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/history/data/model/history_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SelfUserProfileDataSource {
  Future<ResponseWrapper<dynamic>> updateSocialLink(
      {required Map<String, dynamic> body});
  Future<ResponseWrapper<dynamic>> hideAllLinks(
      {required Map<String, dynamic> body});
  Future<ResponseWrapper<dynamic>> getSelfPlatform(
      {required Map<String, dynamic> body});
  Future<ResponseWrapper<dynamic>> delete({required Map<String, dynamic> body});
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
      print("dataResponse===>${dataResponse.data}");
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
  Future<ResponseWrapper<dynamic>> hideAllLinks(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          requestType: RequestType.post,
          url: ApiConstants.hideAllLinks,
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
      print("dataResponse===>${dataResponse.data}");
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
  Future<ResponseWrapper<dynamic>> getSelfPlatform(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<GetPlatformData>(
              body: body,
              requestType: RequestType.post,
              url: ApiConstants.getSelfPlatform,
              fromJson: (json) {
                print("json in data source :-> $json");

                if (json is Map<String, dynamic>) {
                  return GetPlatformData.fromJson(json["data"]);
                }
                throw Exception("Unexpected API response format");
              });
      print("dataResponse===>${dataResponse.data}");
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
  Future<ResponseWrapper<dynamic>> delete(
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
      print("dataResponse===>${dataResponse.data}");
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

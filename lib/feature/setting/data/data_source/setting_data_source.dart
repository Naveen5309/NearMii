import 'dart:developer';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SettingDataSource {
  Future<ResponseWrapper?> contactUS({required Map<String, dynamic> body});
  Future<ResponseWrapper?> radius({required Map<String, dynamic> body});

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
      print("dataResponse===>$dataResponse");
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
      print("dataResponse===>$dataResponse");
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
      print("dataResponse===>$dataResponse");
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
}

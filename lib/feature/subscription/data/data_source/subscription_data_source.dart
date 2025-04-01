import 'dart:developer';

import 'package:NearMii/config/helper.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SubscriptionDataSource {
  Future<ResponseWrapper?> addSubscription(
      {required Map<String, dynamic> body});
}

class SubscriptionDataSourceImpl extends SubscriptionDataSource {
  @override
  Future<ResponseWrapper<dynamic>?> addSubscription(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
          body: body,
          url: ApiConstants.addSubscription,
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
        functionName: "addSubscription",
      ));
    }
  }
}

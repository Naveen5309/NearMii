import 'dart:developer';

import 'package:NearMii/feature/notification/data/model/notification_response_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class NotificationDataSource {
  Future<ResponseWrapper<List<NotificationData>>?> notification(
      {required Map<String, dynamic> body});
}

class NotificationDataSourceImpl extends NotificationDataSource {
  @override
  Future<ResponseWrapper<List<NotificationData>>?> notification(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<List<NotificationData>>(
              body: body,
              requestType: RequestType.post,
              url: ApiConstants.getNotifications,
              fromJson: (json) {
                print("json in data source :-> $json");

                if (json is Map<String, dynamic>) {
                  var myData = List<NotificationData>.from(
                      json["data"].map((x) => NotificationData.fromJson(x)));

                  log("mydata is :-. $myData");
                  return myData;
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
}

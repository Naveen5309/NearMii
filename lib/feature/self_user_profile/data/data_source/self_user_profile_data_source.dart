import 'dart:developer';

import 'package:NearMii/feature/history/data/model/history_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SelfUserProfileDataSource {
  Future<ResponseWrapper<dynamic>> updateSocialLink(
      {required Map<String, dynamic> body});
}

class SelfUserProfileDataSourceImpl extends SelfUserProfileDataSource {
  @override
  Future<ResponseWrapper<dynamic>> updateSocialLink(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<List<HistoryModel>>(
              body: body,
              requestType: RequestType.get,
              url: ApiConstants.updateSocialLink,
              fromJson: (json) {
                print("json in data source :-> $json");

                if (json is Map<String, dynamic>) {
                  var myData = List<HistoryModel>.from(
                      json["data"].map((x) => HistoryModel.fromJson(x)));

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

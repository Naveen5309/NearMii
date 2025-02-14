import 'dart:developer';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';

abstract class SettingDataSource {
  Future<ResponseWrapper?> contactUS({required Map<String, dynamic> body});
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
            // Ensure the response is a map and correctly map it to GetPlatformData
            // if (json is Map<String, dynamic>) {
            //   return dynamic.fromJson(json["data"]);
            // }
            // throw Exception("Unexpected API response format");
          });
      print("dataResponse===>$dataResponse");
      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");
        dynamic model = dataResponse.data!;
        log("user data is:-> $model");
        log("user data is:-> ${dataResponse.token}");

        await Getters.getLocalStorage.saveLoginUser(model);
        await Getters.getLocalStorage.saveToken(dataResponse.token ?? "");
        await Getters.getLocalStorage.saveIsLogin(true);

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

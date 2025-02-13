import 'dart:developer';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';
import '../models/user_model.dart';

abstract class AuthDataSource {
  Future<ResponseWrapper?> logInUser({required Map<String, dynamic> body});
  Future<ResponseWrapper?> getPlatformApi();
}

class AuthDataSourceImpl extends AuthDataSource {
  @override
  Future<ResponseWrapper<UserModel>?> logInUser(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<UserModel>(
        body: body,
        url: ApiConstants.login,
        fromJson: (json) => UserModel.fromJson(json),
      );

      log("data source is :-> $dataResponse");
      if (dataResponse.status == "success") {
        log("user data is:-> ${dataResponse.data}");
        UserModel model = dataResponse.data!;
        log("user data is:-> $model");

        // await Getters.getLocalStorage.saveLoginUser(model);
        // await Getters.getLocalStorage.saveToken(model.token ?? "");
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
}

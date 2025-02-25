import 'package:NearMii/feature/home/data/models/home_data_model.dart';

import '../../../../core/helpers/all_getter.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/response_wrapper/data_response.dart';
import '../models/preferance_model.dart';

abstract class HomeDataSource {
  Future<ResponseWrapper?> getPreferences();
  Future<ResponseWrapper?> getHomeData({required Map<String, dynamic> body});
  Future<ResponseWrapper?> updateCoordinates(
      {required Map<String, dynamic> body});
}

class HomeDataSourceImpl extends HomeDataSource {
  @override
  Future<ResponseWrapper<PreferencesModel>?> getPreferences() async {
    try {
      final dataResponse =
          await Getters.getHttpService.request<PreferencesModel>(
        url: ApiConstants.preferences,
        requestType: RequestType.get,
        fromJson: (json) => PreferencesModel.fromJson(json),
      );
      if (dataResponse.status == "success") {
        return getSuccessResponseWrapper(dataResponse);
      } else {
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

//UPDATE COORDINATES
  @override
  Future<ResponseWrapper<dynamic>?> updateCoordinates(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<dynamic>(
        url: ApiConstants.updateCoordinates,
        body: body,
        requestType: RequestType.post,
        fromJson: (json) => json,
      );
      if (dataResponse.status == "success") {
        return getSuccessResponseWrapper(dataResponse);
      } else {
        return getFailedResponseWrapper(dataResponse.message,
            response: dataResponse.data);
      }
    } catch (e) {
      return getFailedResponseWrapper(exceptionHandler(
        e: e,
        functionName: "updateCoordinates",
      ));
    }
  }

  @override
  Future<ResponseWrapper<List<HomeData>>?> getHomeData(
      {required Map<String, dynamic> body}) async {
    try {
      final dataResponse = await Getters.getHttpService.request<List<dynamic>?>(
        url: ApiConstants.getHomeUserData,
        requestType: RequestType.post,
        body: body,
        fromJson: (json) {
          if (json is Map<String, dynamic> && json.containsKey('data')) {
            return (json['data'] as List<dynamic>)
                .map((item) => HomeData.fromJson(item as Map<String, dynamic>))
                .toList();
          }
          return [];
        },
      ); // fromJson: (json) {
      //   print("json in data source :-> $json");

      //   if (json is Map<String, dynamic>) {
      //     print("json in data source :-> ${json["data"]}");

      //     return HomeData.fromJson(json["data"]);
      //   }
      //   throw Exception("Unexpected API response format");
      // }

      // );
      if (dataResponse.status == "success") {
        return getSuccessResponseWrapper(dataResponse);
      } else {
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

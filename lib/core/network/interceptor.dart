import 'dart:convert';

import 'package:NearMii/feature/auth/presentation/views/login_view.dart';
import 'package:NearMii/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../helpers/all_getter.dart';
import '../../config/helper.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  static final _dio = Dio();
  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  Dio getDio() {
    BaseOptions options = BaseOptions(
        receiveTimeout: const Duration(seconds: 90),
        connectTimeout: const Duration(seconds: 90));
    _dio.options = options;
    _dio.options.followRedirects = false;
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.interceptors.clear();
/*    _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
          error: true,
          request: true,
        ));*/
    _dio.interceptors.add(LoggingInterceptors());
    return _dio;
  }

  static Options? getHeaderToken() {
    String? token = Getters.authToken;
    //int? userId = Getters.getLoginUser?.id;
    if (token != null) {
      //  printLog("Logged in user Id==>>$userId");
      printLog("AuthToken==>> Bearer $token");
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer $token',
        // options.headers['Authorization'] = 'Bearer ' +usertoken!;
      });
      return headerOptions;
    }
    return null;
  }
}

class LoggingInterceptors extends Interceptor {
  String printObject(Object object) {
    Map jsonMapped = json.decode(json.encode(object));
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyPrint = encoder.convert(jsonMapped);
    return prettyPrint;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printLog(
        "--> ${options.method.toUpperCase()} ${"${options.baseUrl}${options.path}"}");
    printLog("Headers:");
    options.headers.forEach((k, v) => printLog('$k: $v'));
    printLog("queryParameters:");
    options.queryParameters.forEach((k, v) => printLog('$k: $v'));
    if (options.data != null) {
      try {
        FormData formData = options.data as FormData;
        printLog("Body:");
        var buffer = [];
        for (MapEntry<String, String> pair in formData.fields) {
          buffer.add('${pair.key}:${pair.value}');
        }
        printLog("Body:{${buffer.join(', ')}}");
      } catch (e) {
        printLog("Body: ${printObject(options.data)}");
      }
    }
    printLog(
        "--> END ${options.method.isNotEmpty ? options.method.toUpperCase() : 'METHOD'}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    printLog(
        "<-- ${response.statusCode} ${(response.requestOptions.baseUrl.isNotEmpty ? (response.requestOptions.baseUrl + response.requestOptions.path) : 'URL')}");
    printLog("Headers:");
    response.headers.forEach((k, v) => printLog('$k: $v'));
    printLog("Response: ${response.data}");
    printLog("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printLog(
        "<-- ${err.message} ${(err.response?.requestOptions != null ? (err.response!.requestOptions.baseUrl + err.response!.requestOptions.path) : 'URL')}");
    printLog("${err.response != null ? err.response!.data : 'Unknown Error'}");
    printLog("<-- End error");
    if (err.response?.statusCode == 401) {
      Getters.getLocalStorage.saveIsLogin(false);
      Getters.getLocalStorage.clearLoginData();

      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginView()),
        (route) => false,
      );
    }
    return super.onError(err, handler);
  }
}

part of '../core/network/http_service.dart';

abstract final class ApiConstants {
  static const String url = "https://php.parastechnologies.in/nearmii";

  static const String socialIconBaseUrl =
      "https://php.parastechnologies.in/nearmii/storage/app/public/uploads/icons/";

  static const String baseUrl = "$url/api/users";
  static const String login = "$baseUrl/login";
  static const String getPlatform = "$baseUrl/getPlatform";

  static const String preferences = "$baseUrl/get/preferences";
}

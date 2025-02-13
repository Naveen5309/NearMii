part of '../core/network/http_service.dart';

abstract final class ApiConstants {
  static const String url = "https://php.parastechnologies.in/nearmii";

  static const String socialIconBaseUrl =
      "https://php.parastechnologies.in/nearmii/storage/app/public/uploads/icons/";

  static const String baseUrl = "$url/api/users";
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";

  static const String completeProfile = "$baseUrl/completeProfile";
  static const String socialLogin = "$baseUrl/socialLogin";
  static const String deleteAccount = "$baseUrl/deleteAccount";
  static const String changePassword = "$baseUrl/changePassword";
  static const String deleteHistory = "$baseUrl/deleteHistory";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";
  // static const String completeProfile = "$baseUrl/completeProfile";

  static const String getPlatform = "$baseUrl/getPlatform";

  static const String preferences = "$baseUrl/get/preferences";
}

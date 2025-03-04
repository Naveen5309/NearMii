part of '../core/network/http_service.dart';

abstract final class ApiConstants {
  static const String url = "https://php.parastechnologies.in/nearmii";

  static const String socialIconBaseUrl =
      "https://php.parastechnologies.in/nearmii/storage/app/public/uploads/icons/";

  static const String profileBaseUrl =
      "https://php.parastechnologies.in/nearmii/storage/app/public/uploads/profile_pictures/";

  static const String baseUrl = "$url/api/users";
  static const String login = "$baseUrl/login";
  static const String register = "$baseUrl/register";
  static const String otherUserProfile = "$baseUrl/profile";
  static const String completeProfile = "$baseUrl/completeProfile";
  static const String socialLogin = "$baseUrl/socialLogin";
  static const String deleteAccount = "$baseUrl/deleteAccount";
  static const String changePassword = "$baseUrl/changePassword";
  static const String deleteHistory = "$baseUrl/deleteHistory";
  static const String logout = "$baseUrl/logout";
  static const String resetPassword = "$baseUrl/resetPassword";
  static const String verifyOtp = "$baseUrl/verifyOtp";
  static const String forgetPassword = "$baseUrl/forgetPassword";

  static const String addPlatform = "$baseUrl/socialprofile";

  static const String contactus = "$baseUrl/contactus";
  static const String updateProfile = "$baseUrl/updateProfile";
  static const String report = "$baseUrl/report";
  static const String getHistory = "$baseUrl/history";
  static const String getHomeUserData = "$baseUrl/userIndex";
  static const String getSelfProfile = "$baseUrl/getSelfProfile";
  static const String updateCoordinates = "$baseUrl/updateLocation";
  static const String updateSocialLink = "$baseUrl/updateSocialLink";
  static const String hideAllLinks = "$baseUrl/hideAllLinks";
  static const String getSelfPlatform = "$baseUrl/getSelfPlatform";
  static const String deletePlatform = "$baseUrl/deleteSocialLink";
  static const String getOtherUserPlatform = "$baseUrl/getsocialprofile";
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

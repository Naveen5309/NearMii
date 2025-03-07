// To parse this JSON data, do
//
//     final newOtherUserSocialPlatformData = newOtherUserSocialPlatformDataFromJson(jsonString);

import 'dart:convert';

import 'package:NearMii/feature/auth/data/models/get_my_platform_model.dart';

NewOtherUserSocialPlatformData newOtherUserSocialPlatformDataFromJson(
        String str) =>
    NewOtherUserSocialPlatformData.fromJson(json.decode(str));

String newOtherUserSocialPlatformDataToJson(
        NewOtherUserSocialPlatformData data) =>
    json.encode(data.toJson());

class NewOtherUserSocialPlatformData {
  String? status;
  List<SelfPlatformCatagoryData>? data;

  NewOtherUserSocialPlatformData({
    this.status,
    this.data,
  });

  factory NewOtherUserSocialPlatformData.fromJson(Map<String, dynamic> json) =>
      NewOtherUserSocialPlatformData(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SelfPlatformCatagoryData>.from(
                json["data"]!.map((x) => SelfPlatformCatagoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SelfPlatformCatagoryData {
  String? title;
  List<SelfPlatformData>? list;

  SelfPlatformCatagoryData({
    this.title,
    this.list,
  });

  factory SelfPlatformCatagoryData.fromJson(Map<String, dynamic> json) =>
      SelfPlatformCatagoryData(
        title: json["title"],
        list: json["list"] == null
            ? []
            : List<SelfPlatformData>.from(
                json["list"]!.map((x) => SelfPlatformData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

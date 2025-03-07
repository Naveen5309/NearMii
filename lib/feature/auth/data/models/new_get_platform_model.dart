// To parse this JSON data, do
//
//     final newGetSocialPlatformData = newGetSocialPlatformDataFromJson(jsonString);

import 'dart:convert';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

NewGetSocialPlatformData newGetSocialPlatformDataFromJson(String str) =>
    NewGetSocialPlatformData.fromJson(json.decode(str));

String newGetSocialPlatformDataToJson(NewGetSocialPlatformData data) =>
    json.encode(data.toJson());

class NewGetSocialPlatformData {
  String? status;
  List<PlatformCatagory>? data;

  NewGetSocialPlatformData({
    this.status,
    this.data,
  });

  factory NewGetSocialPlatformData.fromJson(Map<String, dynamic> json) =>
      NewGetSocialPlatformData(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PlatformCatagory>.from(
                json["data"]!.map((x) => PlatformCatagory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PlatformCatagory {
  String? title;
  List<PlatformData>? list;

  PlatformCatagory({
    this.title,
    this.list,
  });

  factory PlatformCatagory.fromJson(Map<String, dynamic> json) =>
      PlatformCatagory(
        title: json["title"],
        list: json["list"] == null
            ? []
            : List<PlatformData>.from(
                json["list"]!.map((x) => PlatformData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "list": list == null
            ? []
            : List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

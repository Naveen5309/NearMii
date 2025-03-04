import 'dart:convert';

import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';

GetMyPlatformData getMyPlatformDataFromJson(String str) =>
    GetMyPlatformData.fromJson(json.decode(str));

String getMyPlatformDataToJson(GetMyPlatformData data) =>
    json.encode(data.toJson());

class GetMyPlatformData {
  String? status;
  String? message;
  MyPlatformDataList? data;

  GetMyPlatformData({
    this.status,
    this.message,
    this.data,
  });

  factory GetMyPlatformData.fromJson(Map<String, dynamic> json) =>
      GetMyPlatformData(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : MyPlatformDataList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class MyPlatformDataList {
  List<SelfPlatformData>? socialMedia;
  List<SelfPlatformData>? portfolio;
  List<SelfPlatformData>? contactInformation;

  MyPlatformDataList({
    this.socialMedia,
    this.portfolio,
    this.contactInformation,
  });

  factory MyPlatformDataList.fromJson(Map<String, dynamic> json) =>
      MyPlatformDataList(
        socialMedia: json["SocialMedia"] == null
            ? []
            : List<SelfPlatformData>.from(
                json["SocialMedia"]!.map((x) => SelfPlatformData.fromJson(x))),
        portfolio: json["Portfolio"] == null
            ? []
            : List<SelfPlatformData>.from(
                json["Portfolio"]!.map((x) => SelfPlatformData.fromJson(x))),
        contactInformation: json["Contact information"] == null
            ? []
            : List<SelfPlatformData>.from(json["Contact information"]!
                .map((x) => SelfPlatformData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SocialMedia": socialMedia == null
            ? []
            : List<dynamic>.from(socialMedia!.map((x) => x.toJson())),
        "Portfolio": portfolio == null
            ? []
            : List<dynamic>.from(portfolio!.map((x) => x.toJson())),
        "Contact information": contactInformation == null
            ? []
            : List<dynamic>.from(contactInformation!.map((x) => x.toJson())),
      };
}

class SelfPlatformData {
  int? id;
  int? userId;
  int? platformId;
  String? url;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  PlatformData? platform;

  SelfPlatformData({
    this.id,
    this.userId,
    this.platformId,
    this.url,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.platform,
  });

  factory SelfPlatformData.fromJson(Map<String, dynamic> json) =>
      SelfPlatformData(
        id: json["id"],
        userId: json["user_id"],
        platformId: json["platform_id"],
        url: json["url"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        platform: json["platform"] == null
            ? null
            : PlatformData.fromJson(json["platform"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "platform_id": platformId,
        "url": url,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "platform": platform?.toJson(),
      };
}

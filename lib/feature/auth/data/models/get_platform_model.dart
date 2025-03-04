// To parse this JSON data, do
//
//     final getPlatformModel = getPlatformModelFromJson(jsonString);

import 'dart:convert';

GetPlatformModel getPlatformModelFromJson(String str) =>
    GetPlatformModel.fromJson(json.decode(str));

String getPlatformModelToJson(GetPlatformModel data) =>
    json.encode(data.toJson());

class GetPlatformModel {
  String? status;
  GetPlatformData? data;

  GetPlatformModel({
    this.status,
    this.data,
  });

  factory GetPlatformModel.fromJson(Map<String, dynamic> json) =>
      GetPlatformModel(
        status: json["status"],
        data: json["data"] == null
            ? null
            : GetPlatformData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class GetPlatformData {
  List<PlatformData>? socialMedia;
  List<PlatformData>? contactInformation;
  List<PlatformData>? portfolio;

  GetPlatformData({
    this.socialMedia,
    this.contactInformation,
    this.portfolio,
  });

  factory GetPlatformData.fromJson(Map<String, dynamic> json) =>
      GetPlatformData(
        socialMedia: json["SocialMedia"] == null
            ? []
            : List<PlatformData>.from(
                json["SocialMedia"]!.map((x) => PlatformData.fromJson(x))),
        contactInformation: json["Contact information"] == null
            ? []
            : List<PlatformData>.from(json["Contact information"]!
                .map((x) => PlatformData.fromJson(x))),
        portfolio: json["Portfolio"] == null
            ? []
            : List<PlatformData>.from(
                json["Portfolio"]!.map((x) => PlatformData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "SocialMedia": socialMedia == null
            ? []
            : List<dynamic>.from(socialMedia!.map((x) => x.toJson())),
        "Contact information": contactInformation == null
            ? []
            : List<dynamic>.from(contactInformation!.map((x) => x.toJson())),
        "Portfolio": portfolio == null
            ? []
            : List<dynamic>.from(portfolio!.map((x) => x.toJson())),
      };
}

class PlatformData {
  int? id;
  String? name;
  String? type;
  int? categoryId;
  String? icon;

  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  Category? category;

  PlatformData({
    this.id,
    this.name,
    this.type,
    this.categoryId,
    this.icon,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  factory PlatformData.fromJson(Map<String, dynamic> json) => PlatformData(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        categoryId: json["category_id"],
        icon: json["icon"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "category_id": categoryId,
        "icon": icon,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
      };
}

class Category {
  int? id;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

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
  List<PlatformData>? data;

  GetPlatformModel({
    this.status,
    this.data,
  });

  factory GetPlatformModel.fromJson(Map<String, dynamic> json) =>
      GetPlatformModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PlatformData>.from(
                json["data"]!.map((x) => PlatformData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PlatformData {
  int? id;
  String? name;
  int? categoryId;
  String? icon;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  PlatformCatagory? category;

  PlatformData({
    this.id,
    this.name,
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
            : PlatformCatagory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "icon": icon,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
      };
}

class PlatformCatagory {
  int? id;
  String? name;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  PlatformCatagory({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PlatformCatagory.fromJson(Map<String, dynamic> json) =>
      PlatformCatagory(
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

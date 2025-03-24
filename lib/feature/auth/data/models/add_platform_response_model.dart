// To parse this JSON AddPlatformData, do
//
//     final addPlatformResponseModel = addPlatformResponseModelFromJson(jsonString);

import 'dart:convert';

AddPlatformResponseModel addPlatformResponseModelFromJson(String str) =>
    AddPlatformResponseModel.fromJson(json.decode(str));

String addPlatformResponseModelToJson(AddPlatformResponseModel data) =>
    json.encode(data.toJson());

class AddPlatformResponseModel {
  String? status;
  String? message;
  AddPlatformData? data;

  AddPlatformResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory AddPlatformResponseModel.fromJson(Map<String, dynamic> json) =>
      AddPlatformResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : AddPlatformData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class AddPlatformData {
  dynamic userId;
  dynamic platformId;
  String? url;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic id;

  AddPlatformData({
    this.userId,
    this.platformId,
    this.url,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory AddPlatformData.fromJson(Map<String, dynamic> json) =>
      AddPlatformData(
        userId: json["user_id"],
        platformId: json["platform_id"],
        url: json["url"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "platform_id": platformId,
        "url": url,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

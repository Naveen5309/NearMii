// To parse this JSON data, do
//
//     final socialSignupResponseModel = socialSignupResponseModelFromJson(jsonString);

import 'dart:convert';

SocialSignupResponseModel socialSignupResponseModelFromJson(String str) =>
    SocialSignupResponseModel.fromJson(json.decode(str));

String socialSignupResponseModelToJson(SocialSignupResponseModel data) =>
    json.encode(data.toJson());

class SocialSignupResponseModel {
  String? status;
  String? message;
  SocialSignUpData? data;
  String? token;

  SocialSignupResponseModel({
    this.status,
    this.message,
    this.data,
    this.token,
  });

  factory SocialSignupResponseModel.fromJson(Map<String, dynamic> json) =>
      SocialSignupResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : SocialSignUpData.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
        "token": token,
      };
}

class SocialSignUpData {
  dynamic name;
  String? socialId;
  String? socialType;
  String? token;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  SocialSignUpData({
    this.name,
    this.socialId,
    this.socialType,
    this.token,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory SocialSignUpData.fromJson(Map<String, dynamic> json) =>
      SocialSignUpData(
        name: json["name"],
        socialId: json["social_id"],
        socialType: json["social_type"],
        token: json["token"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "social_id": socialId,
        "social_type": socialType,
        "token": token,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

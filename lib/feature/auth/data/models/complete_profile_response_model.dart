// To parse this JSON data, do
//
//     final completeProfileResponseModel = completeProfileResponseModelFromJson(jsonString);

import 'dart:convert';

CompleteProfileResponseModel completeProfileResponseModelFromJson(String str) =>
    CompleteProfileResponseModel.fromJson(json.decode(str));

String completeProfileResponseModelToJson(CompleteProfileResponseModel data) =>
    json.encode(data.toJson());

class CompleteProfileResponseModel {
  String? status;
  String? message;
  CompleteProfileData? data;

  CompleteProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  factory CompleteProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      CompleteProfileResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : CompleteProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class CompleteProfileData {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic socialId;
  dynamic socialType;
  String? designation;
  String? phoneNumber;
  dynamic profilePhoto;
  String? bio;
  String? gender;
  String? dob;
  dynamic otp;
  int? isProfile;
  String? token;
  int? points;
  dynamic deviceType;
  dynamic deviceToken;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  CompleteProfileData({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.socialId,
    this.socialType,
    this.designation,
    this.phoneNumber,
    this.profilePhoto,
    this.bio,
    this.gender,
    this.dob,
    this.otp,
    this.isProfile,
    this.token,
    this.points,
    this.deviceType,
    this.deviceToken,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CompleteProfileData.fromJson(Map<String, dynamic> json) =>
      CompleteProfileData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        socialId: json["social_id"],
        socialType: json["social_type"],
        designation: json["designation"],
        phoneNumber: json["phone_number"],
        profilePhoto: json["profile_photo"],
        bio: json["bio"],
        gender: json["gender"],
        dob: json["dob"],
        otp: json["otp"],
        isProfile: json["is_profile"],
        token: json["token"],
        points: json["points"],
        deviceType: json["device_type"],
        deviceToken: json["device_token"],
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
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "social_id": socialId,
        "social_type": socialType,
        "designation": designation,
        "phone_number": phoneNumber,
        "profile_photo": profilePhoto,
        "bio": bio,
        "gender": gender,
        "dob": dob,
        "otp": otp,
        "is_profile": isProfile,
        "token": token,
        "points": points,
        "device_type": deviceType,
        "device_token": deviceToken,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

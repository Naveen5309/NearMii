// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  int? id;
  int? userId;
  int? profileId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Profile? profile;

  HistoryModel({
    this.id,
    this.userId,
    this.profileId,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        userId: json["user_id"],
        profileId: json["profile_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "profile_id": profileId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
      };
}

class Profile {
  int? id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  String? socialId;
  String? socialType;
  String? designation;
  String? phoneNumber;
  String? profilePhoto;
  dynamic bio;
  String? gender;
  DateTime? dob;
  dynamic otp;
  int? isProfile;
  String? token;
  int? points;
  dynamic deviceType;
  dynamic deviceToken;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Profile({
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

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
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
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
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
        "dob":
            "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
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

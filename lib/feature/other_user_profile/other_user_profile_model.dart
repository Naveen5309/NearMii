class Model {
  String? status;
  String? message;
  OtherUserProfileModel? data;

  Model({
    this.status,
    this.message,
    this.data,
  });
}

class OtherUserProfileModel {
  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic socialId;
  dynamic socialType;
  dynamic designation;
  dynamic phoneNumber;
  dynamic profilePhoto;
  dynamic bio;
  dynamic gender;
  dynamic dob;
  dynamic otp;
  dynamic isProfile;
  String? token;
  dynamic points;
  dynamic deviceType;
  dynamic deviceToken;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  OtherUserProfileModel({
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
  factory OtherUserProfileModel.fromJson(Map<String, dynamic> json) =>
      OtherUserProfileModel(
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

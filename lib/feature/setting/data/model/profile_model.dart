class UserProfileModel {
  final int? id;
  final dynamic name;
  final String? email;
  final dynamic emailVerifiedAt;
  final dynamic socialId;
  final dynamic socialType;
  final dynamic designation;
  final dynamic phoneNumber;
  final String? profilePhoto;
  final dynamic bio;
  final dynamic gender;
  final dynamic dob;
  final dynamic otp;
  final int? isProfile;
  final String? token;
  final int? points;
  final int? hideProfile;
  final dynamic deviceType;
  final dynamic deviceToken;
  final String? lat;
  final String? long;
  final String? location;
  final String? radius;
  final String? status;
  final int? isSubscription;
  final String? subscriptionPlan;
  final String? paymentToken;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? price;

  UserProfileModel({
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
    this.lat,
    this.long,
    this.location,
    this.radius,
    this.hideProfile,
    this.status,
    this.isSubscription,
    this.subscriptionPlan,
    this.paymentToken,
    this.startDate,
    this.endDate,
    this.price,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
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
      hideProfile: json["hideProfile"],
      deviceType: json["device_type"],
      deviceToken: json["device_token"],
      lat: json["lat"],
      long: json["long"],
      location: json["location"],
      radius: json["radius"],
      status: json["status"],
      isSubscription: json["isSubscription"],
      subscriptionPlan: json["subscriptionPlan"],
      paymentToken: json["paymentToken"],
      startDate:
          json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      price: json["price"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      "lat": lat,
      "long": long,
      "location": location,
      "radius": radius,
      "hideProfile": hideProfile ?? false,
      "status": status,
      "isSubscription": isSubscription,
      "subscriptionPlan": subscriptionPlan,
      "paymentToken": paymentToken,
      "startDate": startDate?.toIso8601String(),
      "endDate": endDate?.toIso8601String(),
      "price": price,
    };
  }
}

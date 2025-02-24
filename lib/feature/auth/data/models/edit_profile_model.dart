class EditProfileModel {
  int? id;
  String? name;
  dynamic email;
  dynamic emailVerifiedAt;
  String? socialId;
  String? socialType;
  String? designation;
  String? phoneNumber;
  String? profilePhoto;
  String? bio;
  String? gender;
  DateTime? dob;
  dynamic otp;
  int? isProfile;
  String? token;
  int? points;
  dynamic deviceType;
  dynamic deviceToken;
  String? lat;
  String? long;
  String? location;
  dynamic radius;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  EditProfileModel({
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
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      socialId: json['social_id'] as String?,
      socialType: json['social_type'] as String?,
      designation: json['designation'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
      otp: json['otp'],
      isProfile: json['is_profile'] as int?,
      token: json['token'] as String?,
      points: json['points'] as int?,
      deviceType: json['device_type'],
      deviceToken: json['device_token'],
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      location: json['location'] as String?,
      radius: json['radius'],
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'social_id': socialId,
      'social_type': socialType,
      'designation': designation,
      'phone_number': phoneNumber,
      'profile_photo': profilePhoto,
      'bio': bio,
      'gender': gender,
      'dob': dob?.toIso8601String(),
      'otp': otp,
      'is_profile': isProfile,
      'token': token,
      'points': points,
      'device_type': deviceType,
      'device_token': deviceToken,
      'lat': lat,
      'long': long,
      'location': location,
      'radius': radius,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

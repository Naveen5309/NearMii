class HomeData {
  int? id;
  String? name;
  String? email;
  String? socialId;
  String? socialType;
  String? designation;
  String? phoneNumber;
  String? profilePhoto;
  String? bio;
  DateTime? dob;

  HomeData({
    this.id,
    this.name,
    this.email,
    this.socialId,
    this.socialType,
    this.designation,
    this.phoneNumber,
    this.profilePhoto,
    this.bio,
    this.dob,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      socialId: json['social_id'],
      socialType: json['social_type'],
      designation: json['designation'],
      phoneNumber: json['phone_number'],
      profilePhoto: json['profile_photo'],
      bio: json['bio'],
      dob: json['dob'] != null ? DateTime.parse(json['dob']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'social_id': socialId,
      'social_type': socialType,
      'designation': designation,
      'phone_number': phoneNumber,
      'profile_photo': profilePhoto,
      'bio': bio,
      'dob': dob?.toIso8601String(),
    };
  }
}

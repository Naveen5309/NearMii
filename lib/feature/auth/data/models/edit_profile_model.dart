class EditProfileModel {
  int? id;
  String? name;
  String? designation;
  String? phoneNumber;
  String? profilePhoto;
  String? bio;
  String? gender;
  DateTime? dob;

  EditProfileModel({
    this.id,
    this.name,
    this.designation,
    this.phoneNumber,
    this.profilePhoto,
    this.bio,
    this.gender,
    this.dob,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      designation: json['designation'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePhoto: json['profile_photo'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] as String?,
      dob: json['dob'] != null ? DateTime.tryParse(json['dob']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'phone_number': phoneNumber,
      'profile_photo': profilePhoto,
      'bio': bio,
      'gender': gender,
      'dob': dob?.toIso8601String(),
    };
  }
}

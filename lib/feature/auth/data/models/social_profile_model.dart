class SocialProfileModel {
  final String? name;
  final String? img;
  final String? email;

  SocialProfileModel({
    this.name,
    this.img,
    this.email,
  });

  // Factory constructor to create an instance from a JSON map
  factory SocialProfileModel.fromJson(Map<String, dynamic> json) {
    return SocialProfileModel(
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      email: json['email'] ?? '',
    );
  }

  // Convert the model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'img': img,
      'email': email,
    };
  }
}

class AddSocialProfileModel {
  int? platformId;
  String? url;
  String? type;

  AddSocialProfileModel({
    required this.platformId,
    required this.url,
    required this.type,
  });

  factory AddSocialProfileModel.fromJson(Map<String, dynamic> json) =>
      AddSocialProfileModel(
        platformId: json["platform_id"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "platform_id": platformId,
        "url": url,
        "type": type,
      };
}

class AddSocialMediaList {
  int? platformId;
  String? url;

  AddSocialMediaList({
    required this.platformId,
    required this.url,
  });

  factory AddSocialMediaList.fromJson(Map<String, dynamic> json) =>
      AddSocialMediaList(
        platformId: json["platform_id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "platform_id": platformId,
        "url": url,
      };
}

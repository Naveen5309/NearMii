class NotificationEntity {
  String? title;
  String? body;
  String? type;

  NotificationEntity({
    this.title,
    this.body,
    this.type,
  });

  NotificationEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body'] = body;
    data['title'] = title;
    return data;
  }
}

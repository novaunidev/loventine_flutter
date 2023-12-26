class UserMeeting {
  final String id;
  final String name;
  final String? avatar_url;

  const UserMeeting({
    required this.id,
    required this.name,
    this.avatar_url,
  });

  factory UserMeeting.fromJson(Map<String, dynamic> json) {
    return UserMeeting(
      id: json['partner']['_id'] == null
          ? ''
          : json['partner']['_id'] as String,
      name: json['partner']['name'] == null
          ? ''
          : json['partner']['name'] as String,
      avatar_url: json['partner']['avatarUrl'] == null
          ? ''
          : json['partner']['avatarUrl'] as String,
    );
  }

  Map toJson() {
    return {'id': id, 'name': name, 'img': avatar_url};
  }
}

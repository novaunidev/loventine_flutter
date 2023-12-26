class UserResume {
  final String id;
  final String title;
  final List<dynamic> content;

  const UserResume({
    required this.id,
    required this.title,
    required this.content,
  });

  factory UserResume.fromMap(Map<String, dynamic> map) {
    return UserResume(
      title: map['title'],
      content: map['content'],
      id: map['_id'],
    );
  }
}

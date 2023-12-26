class UserSkill {
  final String id;
  final String skillName;

  const UserSkill({
    required this.id,
    required this.skillName,
  });

  static toUserSkill(Map<String, dynamic> data) {
    return UserSkill(
      id: data["_id"] ?? "",
      skillName: data["skillName"] ?? "",
    );
  }
}

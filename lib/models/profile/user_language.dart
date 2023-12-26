class UserLanguage {
  final String id;
  final String languageName;
  final String languageStatus;
  final String levelSpeakId;
  final String levelWriteId;

  const UserLanguage({
    required this.id,
    required this.languageName,
    required this.languageStatus,
    required this.levelSpeakId,
    required this.levelWriteId,
  });

  static toUserLanguage(Map<String, dynamic> data) {
    return UserLanguage(
      id: data["_id"] ?? "",
      languageName: data["languageName"] ?? "",
      languageStatus: data["languageStatus"] ?? "",
      levelSpeakId: data["levelSpeakId"] ?? "",
      levelWriteId: data["levelWriteId"] ?? "",
    );
  }
}

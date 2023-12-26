class UserEducation {
  final String id;
  final String level;
  final String schoolName;
  final String majors;
  final String educationStartDate;
  final String educationEndDate;
  final String educationDescribe;

  const UserEducation(
      {required this.id,
      required this.level,
      required this.schoolName,
      required this.majors,
      required this.educationStartDate,
      required this.educationEndDate,
      required this.educationDescribe});

  static toUserEducation(Map<String, dynamic> data) {
    return UserEducation(
      id: data["_id"] ?? "",
      level: data["level"] ?? "",
      schoolName: data["schoolName"] ?? "",
      majors: data["majors"] ?? "",
      educationStartDate: data["educationStartDate"] ?? "",
      educationEndDate: data["educationEndDate"] ?? "",
      educationDescribe: data["educationDescribe"] ?? ""
    );
  }
}

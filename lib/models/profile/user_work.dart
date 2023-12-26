class UserWork {
  final String id;
  final String position;
  final String company;
  final String workStartDate;
  final String workEndDate;
  final String workDescribe;

  const UserWork({
    required this.id,
    required this.position,
    required this.company,
    required this.workStartDate,
    required this.workEndDate,
    required this.workDescribe
  });

  static toUserWork(Map<String, dynamic> data) {
    return UserWork(
      id: data["_id"] ?? "",
      position: data["position"] ?? "",
      company: data["company"] ?? "",
      workStartDate: data["workStartDate"] ?? "",
      workEndDate: data["workEndDate"] ?? "",
      workDescribe: data["workDescribe"] ?? ""
    );
  }
}

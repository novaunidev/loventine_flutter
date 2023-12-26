class BannerHome {
  final String id;
  final String afternoon;
  final String evening;
  final String morning;

  BannerHome({
    required this.id,
    required this.afternoon,
    required this.evening,
    required this.morning,
  });

  factory BannerHome.fromJson(Map<String, dynamic> json) {
    return BannerHome(
      id: json['_id'] ?? "",
      afternoon: json['afternoon'] ?? "",
      evening: json['evening'] ?? "",
      morning: json['morning'] ?? "",
    );
  }
}

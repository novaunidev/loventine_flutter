class UserProfile {
  late String password;
  late String email;
  late String name;
  late bool verified;
  String? about;
  String? bio;
  String? birthday;
  String? phone;
  String? address;
  UserProfile({
    required this.password,
    required this.email,
    required this.name,
    required this.verified,
    this.about,
    this.bio,
    this.birthday,
    this.phone,
    this.address,
  });

  UserProfile.fromJson(Map json) {
    password = json['password'];
    name = json['name'];
    email = json['email'] ?? "";
    verified = json['verified'];
    about = json['about'] ?? "";
    bio = json['bio'] ?? "";
    birthday = json['birthday'] ?? "";
    phone = json['phone'] ?? "";
    address = json['address'] ?? "";
  }
}
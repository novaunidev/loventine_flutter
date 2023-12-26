import 'package:hive/hive.dart';

part 'userid.g.dart';

@HiveType(typeId: 0)
class UserId extends HiveObject {
  @HiveField(0)
  String? userid;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? avatarUrl;

  @HiveField(3)
  String? avatarCloundinaryPublicId;

  UserId({this.userid, this.name, this.avatarUrl, this.avatarCloundinaryPublicId});
}

import 'package:hive/hive.dart';

part 'image_url.g.dart';

@HiveType(typeId: 2)
class ImageUrl extends HiveObject {
  @HiveField(0)
  String? bannerMorning;

  @HiveField(1)
  String? bannerAfternoon;

  @HiveField(2)
  String? bannerEvening;

  ImageUrl({this.bannerMorning, this.bannerAfternoon, this.bannerEvening});
}

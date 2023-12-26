import 'package:hive/hive.dart';

part 'count_app.g.dart';

@HiveType(typeId: 1)
class CountApp extends HiveObject {
  @HiveField(1)
  bool? countOnboarding;

  CountApp({this.countOnboarding});
}

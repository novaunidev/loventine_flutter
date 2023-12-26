import 'package:json_annotation/json_annotation.dart';

part 'enum_helper.dart';

enum AdviseType {
  @JsonValue(0)
  package,
  @JsonValue(1)
  daily,
  @JsonValue(2)
  hourly,
  @JsonValue(3)
  monthly,
  @JsonValue(3)
  yearly,
}

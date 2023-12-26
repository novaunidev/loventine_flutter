import 'package:json_annotation/json_annotation.dart';
part 'filter.g.dart';

@JsonSerializable(explicitToJson: true)
class Filter {
  double? minPrice;
  double? maxPrice;
  String? keyWord;
  String? postType;
  String? adviseType;

  Filter({
    this.minPrice,
    this.maxPrice,
    this.keyWord,
    this.postType,
    this.adviseType,
  });

  factory Filter.fromJson(Map<String, dynamic> json) => _$FilterFromJson(json);
  Map<String, dynamic> toJson() => _$FilterToJson(this);
}

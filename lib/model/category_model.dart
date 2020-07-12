import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

List<CategoryModel> getCategoryModelList(List<dynamic> list) {
  List<CategoryModel> result = [];
  list.forEach((item) {
    result.add(CategoryModel.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class CategoryModel extends Object {
  @JsonKey(name: '_id')
  String id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: '__v')
  int v;

  CategoryModel(
    this.id,
    this.name,
    this.v,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> srcJson) =>
      _$CategoryModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

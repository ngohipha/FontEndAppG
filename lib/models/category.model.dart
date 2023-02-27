import 'package:fontend/config.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.model.freezed.dart';
part 'category.model.g.dart';

List<Category> categoriesFromJson(dynamic str) =>
    List<Category>.from((str).map((e) => Category.fromJson(e)));

@freezed
abstract class Category with _$Category {
  factory Category(
      {required String categoryName,
      required String categoryImage,
      required String categoryId}) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}

extension CategoryExt on Category {
  String get fullImagePath => Config.imageURL + categoryImage;
}

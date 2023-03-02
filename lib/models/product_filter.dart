import 'package:fontend/models/pagination.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_filter.freezed.dart';
@freezed

// model loc san pham
abstract class ProductFilterModel with _$ProductFilterModel {
  factory ProductFilterModel({
    required PaginationModel paginationModel,
    String? categoryId,
    String? sortBy,
  }) = _ProductFilterModel;
}

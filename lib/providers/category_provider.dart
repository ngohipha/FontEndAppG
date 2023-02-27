import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/api/api.service.dart';
import 'package:fontend/models/category.model.dart';
import 'package:fontend/models/pagination.dart';

final categoriesProvider =
    FutureProvider.family<List<Category>?, PaginationModel>(
  (ref, paginationModel) {
    final apiRepository = ref.watch(apiService);
    return apiRepository.getCategories(
      paginationModel.page,
      paginationModel.pageSize,
    );
  },
);

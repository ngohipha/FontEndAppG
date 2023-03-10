import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/api/api.service.dart';
import 'package:fontend/application/notifier/product_filter_notifier.dart';
import 'package:fontend/application/notifier/product_notifier.dart';
import 'package:fontend/models/category.model.dart';
import 'package:fontend/models/pagination.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/models/product_filter.dart';
import 'package:fontend/models/slider.dart';

import '../application/state/product_state.dart';

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

final homeProductProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRespository = ref.watch(apiService);
  return apiRespository.getProducts(productFilterModel);
});

final productsFilterProvider =
    StateNotifierProvider<ProductsFilterNotifier, ProductFilterModel>(
        (ref) => ProductsFilterNotifier());

final productsNotifierProvider =
    StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) => ProductsNotifier(
    ref.watch(apiService),
    ref.watch(productsFilterProvider),
  ),
);

final slidersProvider =
    FutureProvider.family<List<SliderModel>?, PaginationModel>(
        (ref, paginatioModel) {
  final sliderRepo = ref.watch(apiService);
  return sliderRepo.getSliders(paginatioModel.page, paginatioModel.pageSize);
});

final productDetailsProvider =
    FutureProvider.family<Product?, String>((ref, productId) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProductDetails(productId);
});

final relatedProductsProvider =
    FutureProvider.family<List<Product>?, ProductFilterModel>(
        (ref, productFilterModel) {
  final apiRepository = ref.watch(apiService);
  return apiRepository.getProducts(productFilterModel);
});

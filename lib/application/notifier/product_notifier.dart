import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/api/api.service.dart';
import 'package:fontend/application/state/product_state.dart';
import 'package:fontend/models/pagination.dart';
import 'package:fontend/models/product_filter.dart';

class ProductsNotifier extends StateNotifier<ProductsState> {
  final APIService _apiService;
  final ProductFilterModel _filterModel;
  ProductsNotifier(this._apiService, this._filterModel)
      : super(const ProductsState());
  int _page = 1;
  Future<void> getProducts() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    // neu true cap nhap
    state = state.copyWith(isLoading: true);
    var filterModel = _filterModel.copyWith(
      paginationModel: PaginationModel(page: _page, pageSize: 10),
    );
    // noi san pham 1 trang la 10 san pham tt se them 10 san pham
    final products = await _apiService.getProducts(filterModel);
    final newProducts = [...state.products, ...products!];

    if (products.length % 10 != 0 || products.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(milliseconds: 1500), () {
      state = state.copyWith(products: newProducts);
      _page++;
      state = state.copyWith(isLoading: false);
    });
  }

  Future<void> refreshProducts() async {
    state = state.copyWith(products: [], hasNext: true);
    _page = 1;
    await getProducts();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/components/product_card.dart';
import 'package:fontend/models/pagination.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/models/product_filter.dart';
import 'package:fontend/providers/provider.dart';

class RelatedProductsWidget extends ConsumerWidget {
  final List<String> relatedProducts;
  const RelatedProductsWidget(this.relatedProducts, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: Column(
        children: [
          Text(
            "Related Products",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Visibility(
            child: _productList(ref),
            visible: relatedProducts.isNotEmpty,
          )
        ],
      ),
    );
  }

  Widget _productList(WidgetRef ref) {
    final products = ref.watch(
      relatedProductsProvider(
        ProductFilterModel(
            paginationModel: PaginationModel(page: 1, pageSize: 10),
            productIds: relatedProducts),
      ),
    );
    return products.when(
        data: (list) {
          return _buildProductList(list!);
        },
        error: (_, __) => const Center(
              child: Text("error"),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            var data = products[index];
            return GestureDetector(
              onTap: () {},
              child: ProductCard(model: data),
            );
          }),
    );
  }
}

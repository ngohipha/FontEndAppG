import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/models/pagination.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/models/product_filter.dart';
import 'package:fontend/components/product_card.dart';
import 'package:fontend/providers/provider.dart';

class HomeProductsWidget extends ConsumerWidget {
  const HomeProductsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // List<Product> list = List<Product>.empty(growable: true);
    // list.add(context)

    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                padding:  EdgeInsets.all(8.0),
                child: Text(
                  "Top 10 Products",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: _productsList(ref),
          ),
        ],
      ),
    );
  }

  Widget _productsList(WidgetRef ref) {
    final products = ref.watch(homeProductProvider(ProductFilterModel(
        paginationModel: PaginationModel(page: 1, pageSize: 10))));
    return products.when(
        data: (list) {
          return _buildProductList(list!);
        },
        error: (_, __) {
          return const Center(child: Text("Err"));
        },
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget _buildProductList(List<Product> products) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return GestureDetector(
            onTap: () {},
            child: ProductCard(
              model: data,
            ),
          );
        },
      ),
    );
  }
}

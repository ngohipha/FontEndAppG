import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/components/widget_col_exp.dart';
import 'package:fontend/components/widget_custom_stepper.dart';
import 'package:fontend/config.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/providers/provider.dart';
import 'package:fontend/widgets/widget_related_products.dart';

class ProductDetailsPage extends ConsumerStatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends ConsumerState<ProductDetailsPage> {
  String productId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
      ),
      body: SingleChildScrollView(
        child: _productDetails(ref),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map;

    if (arguments != null) {
      productId = arguments["productId"];
    }
    super.didChangeDependencies();
  }

  Widget _productDetails(WidgetRef ref) {
    final details = ref.watch(productDetailsProvider(productId));

    return details.when(
        data: (model) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _productDetailsUI(model!),
              RelatedProductsWidget(model.relatedProducts!),
              SizedBox(
                height: 20,
              )
            ],
          );
        },
        error: (_, __) => const Center(
              child: Text("err"),
            ),
        loading: () => Center(
              child: CircularProgressIndicator(),
            ));
  }

  Widget _productDetailsUI(Product model) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Image.network(
              model.fullImagePath,
              fit: BoxFit.fitHeight,
            ),
            height: 200,
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            model.productName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "${Config.currency}${model.productPrice.toString()}",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 20,
                        color: model.calculateDiscount > 0
                            ? Colors.red
                            : Colors.black,
                        decoration: model.productSalePrice > 0
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  Text(
                    (model.calculateDiscount > 0)
                        ? " ${Config.currency}${model.productSalePrice.toString()}"
                        : "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              TextButton.icon(
                  onPressed: () {},
                  icon: const Text(
                    "SHARE",
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ),
                  label: const Icon(
                    Icons.share,
                    color: Colors.black,
                    size: 20,
                  ))
            ],
          ),
          Text(
            "Availability: ${model.stockStatus}",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Product Code: ${model.productSKU}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStepper(
                iconSize: 22.0,
                lowerLimit: 1,
                upperLimit: 20,
                stepValue: 1,
                value: 1,
                onChanged: (value) {},
              ),
              TextButton.icon(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  icon: const Icon(
                    Icons.shopping_basket,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Add to Cart",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ColExpand(
            title: "SHORT DESCRIPTION",
            content: model.productShortDescription,
          )
        ],
      ),
    );
  }
}

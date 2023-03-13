import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/config.dart';
import 'package:fontend/models/cart.dart';
import 'package:fontend/models/cart_product.dart';
import 'package:fontend/providers/provider.dart';
import 'package:fontend/widgets/widget_cart_item.dart';
import 'package:http/http.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      bottomNavigationBar: _checkoutBottomNavbar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: _cartList(ref),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItems(List<CartProduct> cartProducts, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: cartProducts.length,
      itemBuilder: (context, index) {
        return CartItemWidget(
          model: cartProducts[index],
          onQtyUpdate: (CartProduct model, qty, type) {
            final cartViewModel = ref.read(cartItemsProvider.notifier);
            cartViewModel.updateQty(model.product.productId, qty, type);
          },
          onItemRemove: (CartProduct model) {
            final cartViewModel = ref.read(cartItemsProvider.notifier);
            cartViewModel.removeCartItem(model.product.productId, model.qty);
          },
        );
      },
    );
  }

  Widget _cartList(WidgetRef ref) {
    final cartState = ref.watch(cartItemsProvider);
    if (cartState.cartModel == null) {
      return const LinearProgressIndicator();
    }
    if (cartState.cartModel!.products.isEmpty) {
      return const Center(
        child: Text('Cart Empty'),
      );
    }
    return _buildCartItems(cartState.cartModel!.products, ref);
  }
}

class _checkoutBottomNavbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProvider = ref.watch(cartItemsProvider);

    if (cartProvider.cartModel != null) {
      return cartProvider.cartModel!.products.isNotEmpty
          ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total : ${Config.currency}${cartProvider.cartModel!.grandTotal.toString()}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ),
          )
          : const SizedBox();
    }
    return const SizedBox();
  }
}

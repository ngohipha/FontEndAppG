import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/api/api.service.dart';
import 'package:fontend/application/state/cart_state.dart';
import 'package:fontend/models/cart_product.dart';

class CartNotifier extends StateNotifier<CartState> {
  final APIService _apiService;
  CartNotifier(this._apiService) : super(const CartState()) {
    getCartItems();
  }
  Future<void> getCartItems() async {
    state = state.copyWith(isLoading: true);
    final cartData = await _apiService.getCart();
    state = state.copyWith(cartModel: cartData);
    state = state.copyWith(isLoading: false);
  }

  Future<void> addCartItem(productId, qty) async {
    await _apiService.addCartItem(productId, qty);
    await getCartItems();
  }

  Future<void> removeCartItem(productId, qty) async {
    await _apiService.removeCartItem(productId, qty);
    var isCartItemExist = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);

    var updateItems = state.cartModel!;
    // tạo 1 danh sách mới 
    List<CartProduct> cartProducts = List.from(updateItems.products);
    cartProducts.remove(isCartItemExist);
    updateItems = updateItems.copyWith(products: cartProducts);

    state = state.copyWith(cartModel: updateItems);
  }

  Future<void> updateQty(productId, qty, type) async {
    var cartItem = state.cartModel!.products
        .firstWhere((element) => element.product.productId == productId);

    var updatedItems = state.cartModel!;
    // kt loai do co bi tru` hay k
    if (type == "-") {
      await _apiService.removeCartItem(productId, 1);
      if (cartItem.qty > 1) {
        CartProduct cartProduct =
            CartProduct(qty: cartItem.qty - 1, product: cartItem.product);
        List<CartProduct> cartProducts = List.from(updatedItems.products);
        cartProducts.remove(cartItem);
        cartProducts.add(cartProduct);
        updatedItems = updatedItems.copyWith(products: cartProducts);
      } else {
        List<CartProduct> cartProducts = List.from(updatedItems.products);
        cartProducts.remove(cartItem);
        updatedItems = updatedItems.copyWith(products: cartProducts);
      }
    } else {
      await _apiService.addCartItem(productId, 1);
      CartProduct cartProduct =
          CartProduct(qty: cartItem.qty + 1, product: cartItem.product);
      List<CartProduct> cartProducts = List.from(updatedItems.products);
      cartProducts.remove(cartItem);
      cartProducts.add(cartProduct);
      updatedItems = updatedItems.copyWith(products: cartProducts);
    }
    state = state.copyWith(cartModel: updatedItems);
  }
}

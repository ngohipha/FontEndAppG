import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fontend/models/cart.dart';
import 'package:fontend/models/category.model.dart';
import 'package:fontend/models/login_response_model.dart';
import 'package:fontend/models/product.dart';
import 'package:fontend/models/product_filter.dart';
import 'package:fontend/models/slider.dart';
import 'package:fontend/utils/shared_service.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../main.dart';

final apiService = Provider((ref) => APIService());

class APIService {
  static var client = http.Client();
  Future<List<Category>?> getCategories(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString(),
    };
    var url = Uri.http(Config.apiURL, Config.categoryAPI, queryString);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return categoriesFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<List<Product>?> getProducts(
      ProductFilterModel productFilterModel) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    Map<String, String> queryString = {
      'page': productFilterModel.paginationModel.page.toString(),
      'pageSize': productFilterModel.paginationModel.pageSize.toString(),
    };

    if (productFilterModel.categoryId != null) {
      queryString["categoryId"] = productFilterModel.categoryId!;
    }
    if (productFilterModel.sortBy != null) {
      queryString["sort"] = productFilterModel.sortBy!;
    }
    // check id san pham co hay k  , dau , kt ngay thang
    if (productFilterModel.productIds != null) {
      queryString["productIds"] = productFilterModel.productIds!.join(",");
    }
    var url = Uri.http(Config.apiURL, Config.productAPI, queryString);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return productsFromJson(data["data"]);
    } else {
      return null;
    }
  }

  static Future<bool> registerUser(
    String fullName,
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.registerAPI);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"fullName": fullName, "email": email, "password": password},
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> loginUser(
    String email,
    String password,
  ) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(url,
        headers: requestHeaders,
        body: jsonEncode({"email": email, "password": password}));
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  Future<List<SliderModel>?> getSliders(page, pageSize) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    Map<String, String> queryString = {
      'page': page.toString(),
      'pageSize': pageSize.toString()
    };

    var url = Uri.http(Config.apiURL, Config.sliderAPI, queryString);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return sliderFromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Product?> getProductDetails(String productId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.productAPI + "/" + productId);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Product.fromJson(data["data"]);
    } else {
      return null;
    }
  }

  Future<Cart?> getCart() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // noi dung de dung token de xem gio hang
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartAPI);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Cart.fromJson(data["data"]);
      // dan den trang dang nhap
    } else if (response.statusCode == 401) {
      navigatorkey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    } else {
      return null;
    }
  }

  Future<bool?> addCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // noi dung de dung token de xem gio hang
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {
          "products": [
            {
              "product": productId,
              "qty": qty,
            }
          ]
        },
      ),
    );

    if (response.statusCode == 200) {
      return true;
      // dan den trang dang nhap
    } else if (response.statusCode == 401) {
      navigatorkey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    } else {
      return null;
    }
  }

  Future<bool?> removeCartItem(productId, qty) async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      // noi dung de dung token de xem gio hang
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}'
    };
    var url = Uri.http(Config.apiURL, Config.cartAPI);

    var response = await client.delete(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        
        {
          "productId": productId,
          "qty": qty,
         },
      ),
    );

    if (response.statusCode == 200) {
      return true;
      // dan den trang dang nhap
    } else if (response.statusCode == 401) {
      navigatorkey.currentState
          ?.pushNamedAndRemoveUntil("/login", (route) => false);
    } else {
      return null;
    }
  }
}

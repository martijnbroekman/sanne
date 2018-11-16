import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';

import '../models/product.dart';

final _root = 'http://178.62.247.245:8000';

class ProductsApiProvider {
  Client client = Client();

  Future<ProductPage> getProducts({int page = 1}) async {
    final response = await client.get('$_root/products/?page=$page');
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final productPage = ProductPage.fromJson(parsedJson);

      return productPage;
    }
    return null;
  }

  Future<List<Product>> getDiscountProducts() async {
    final response = await client.get('$_root/products/discount');
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final products = parsedJson.map<Product>((p) => Product.fromJson(p)).toList();

      return products;
    }
    return null;
  }

  Future<List<Product>> getProductsByKeyWord(String keyword) async {
    final response = await client.get('$_root/products/?search=$keyword');
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final productPage = ProductPage.fromJson(parsedJson);

      return productPage.results;
    }
    return null;
  }

  Future<Product> getProduct(int id) async {
    final response = await client.get('$_root/products/$id');
    final parsedJson = json.decode(response.body);

    return Product.fromJson(parsedJson);
  }
}

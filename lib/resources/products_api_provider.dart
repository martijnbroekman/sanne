import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';

import '../models/product.dart';

final _root = 'http://178.62.247.245:8000';

class ProductsApiProvider {
  Client client = Client();

  Future<List<Product>> getProducts({int page = 1}) async {
    final response = await client.get('$_root/products/?page=$page');
    final parsedJson = json.decode(response.body);
    final products = <Product>[];
    parsedJson.map((p) => products.add(Product.fromJson(p)));
    
    return products;
  }

  Future<List<Product>> getProductsByKeyWord(String keyword) async {
    final response = await client.get('$_root/products/?search=$keyword');
    final parsedJson = json.decode(response.body);
    
    final productPage = ProductPage.fromJson(parsedJson);
    //parsedJson.forEach((p) => products.add(Product.fromJson(p)));
    
    return productPage.results;
  }

  Future<Product> getProduct(int id) async {
    final response = await client.get('$_root/products/$id');
    final parsedJson = json.decode(response.body);

    return Product.fromJson(parsedJson);
  }
}
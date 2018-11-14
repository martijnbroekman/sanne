import 'dart:async';
import 'products_api_provider.dart';
import '../models/product.dart';

class ProductsRespository {
  final productsApi = ProductsApiProvider();

  Future<ProductPage> getProducts({int page = 1}) {
    return productsApi.getProducts(page: page);
  }

  Future<List<Product>> getProductsByKeyWord(String keyword) {
    return productsApi.getProductsByKeyWord(keyword);
  }

  Future<Product> getProduct(int id) async {
    return productsApi.getProduct(id);
  }
}

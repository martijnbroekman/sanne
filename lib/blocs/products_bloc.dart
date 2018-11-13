import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../models/product.dart';
import '../resources/products_repository.dart';

class ProductsBloc {
  final _productsRepository = ProductsRespository();
  final _searchProducts = PublishSubject<List<Product>>();
  final _shoppingList = <Product>[];
  
  // Get from database on contruction
  final shoppingList = <Product>[];

  // Getters to Streams
  Observable<List<Product>> get foundProducts => _searchProducts.stream;

  getProductByKeyWord(String keyword) async {
    print(keyword);
    final products = await _productsRepository.getProductsByKeyWord(keyword);
    print(products);
    _searchProducts.sink.add(products);
  }

  // void addToShoppingList(Product product) {
  //   _searchProducts.
  // }

  void dispose() {
    _searchProducts.close();
  }
}
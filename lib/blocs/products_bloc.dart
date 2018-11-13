import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:collection';
import '../models/product.dart';
import '../resources/products_repository.dart';

class ProductsBloc {
  final _productsRepository = ProductsRespository();
  final _searchProducts = PublishSubject<List<Product>>();

  // Get from database on contruction
  final _shoppingList = HashMap<int, Product>();

  Iterable<Product> get shopptingList => _shoppingList.values;

  // Getters to Streams
  Observable<List<Product>> get foundProducts => _searchProducts.stream;

  void changeShoppingList(Product product) {
    if (product.count == 1) {
      _shoppingList[product.id] = product;
    } else if (product.count < 1) {
      _shoppingList.remove(product.id);
    }
  }

  getProductByKeyWord(String keyword) async {
    var products = await _productsRepository.getProductsByKeyWord(keyword);

    products = products.map((p) {
      if (_shoppingList.containsKey(p.id)) {
        return _shoppingList[p.id];
      }
      return p;
    }).toList();

    _searchProducts.sink.add(products);
  }

  void dispose() {
    _searchProducts.close();
  }
}

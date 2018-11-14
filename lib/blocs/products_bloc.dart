import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'dart:collection';
import '../models/product.dart';
import '../resources/products_repository.dart';

class ProductsBloc {
  final _productsRepository = ProductsRespository();
  final _searchProducts = PublishSubject<List<Product>>();
  final _allProducts = PublishSubject<List<Product>>();

  List<Product> _allProductsChache = <Product>[];
  int _maxProducts = 0;

  // Get from database on contruction
  final _shoppingList = HashMap<int, Product>();

  Iterable<Product> get shopptingList => _shoppingList.values;

  // Getters to Streams
  Observable<List<Product>> get foundProducts => _searchProducts.stream;
  Observable<List<Product>> get allProducts => _allProducts.stream;

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

  getProducts() async {
    int pageNumber = 1;
    if (_maxProducts != 0) {
      if (_allProductsChache.length < _maxProducts) {
        pageNumber = (_allProductsChache.length / 10).round() + 1;
      } else {
        _allProductsChache = _allProductsChache.map((p) {
          if (_shoppingList.containsKey(p.id)) {
            return _shoppingList[p.id];
          }
          return p;
        }).toList();
        _allProducts.sink.add(_allProductsChache);
        return;
      }
    }

    await _productsRepository.getProducts(page: pageNumber).then((productPage) {
      if (productPage != null) {
        _maxProducts = productPage.count;

        if (_maxProducts == 0 || (_allProductsChache.length + productPage.results.length) <=
            _maxProducts) {
          List<Product> products = productPage.results;
          products = products.map((p) {
            if (_shoppingList.containsKey(p.id)) {
              return _shoppingList[p.id];
            }
            return p;
          }).toList();

          _allProductsChache.addAll(products);
        }
        _allProducts.sink.add(_allProductsChache);
      }
    });
  }

  dispose() {
    _searchProducts.close();
    _allProducts.close();
  }
}

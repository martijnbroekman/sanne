import 'package:rxdart/rxdart.dart';
import 'dart:async';

import '../models/product.dart';
import '../resources/products_repository.dart';
import '../resources/shopping_list_repository.dart';

class ProductsBloc {
  final _productsRepository = ProductsRespository();
  final _shoppingListRepository = ShoppingListRepository();
  final _searchProducts = PublishSubject<List<Product>>();
  final _allProducts = PublishSubject<List<Product>>();
  final _discountProducts = PublishSubject<List<Product>>();

  List<Product> _allProductsChache = <Product>[];

  int _maxProducts = 0;

  // Getters to Streams
  Observable<List<Product>> get foundProducts => _searchProducts.stream;
  Observable<List<Product>> get allProducts => _allProducts.stream;
  Observable<List<Product>> get discountProducts => _discountProducts.stream;

  Future<void> changeShoppingList(Product product) {
    return _shoppingListRepository.changeShoppingList(product);
  }

  Future<List<Product>> getShoppingList() {
    return _shoppingListRepository.getProducts();
  }

  getProductByKeyWord(String keyword) async {
    var products = await _productsRepository.getProductsByKeyWord(keyword);
    products = await _shoppingListRepository.mergeProductsWithShoppingList(products);

    _searchProducts.sink.add(products);
  }

  getDiscounts() async {
    _discountProducts.sink.add(await _shoppingListRepository.mergeProductsWithShoppingList(await _productsRepository.getDiscountProducts()));
  }

  getProducts() async {
    int pageNumber = 1;
    if (_maxProducts != 0) {
      if (_allProductsChache.length < _maxProducts) {
        pageNumber = (_allProductsChache.length / 10).round() + 1;
      } else {
        _allProductsChache = await _shoppingListRepository
            .mergeProductsWithShoppingList(_allProductsChache);
        _allProducts.sink.add(_allProductsChache);
        return;
      }
    }

    final productPage = await _productsRepository.getProducts(page: pageNumber);

    if (productPage != null) {
      _maxProducts = productPage.count;

      if (_maxProducts == 0 ||
          (_allProductsChache.length + productPage.results.length) <=
              _maxProducts) {

        List<Product> products = productPage.results;

        _allProductsChache.addAll(products);
        await _mergeChacheWithShoppingList();
      }
      _allProducts.sink.add(_allProductsChache);
    }
  }

  Future<Product> getProduct(int id) async {
    return _shoppingListRepository.mergeProductWithShoppingList(await _productsRepository.getProduct(id));
  }

  Future<void> _mergeChacheWithShoppingList() async {
    for(var product in _allProductsChache) {
      product.count = 0;
    }

    _allProductsChache = await _shoppingListRepository.mergeProductsWithShoppingList(_allProductsChache);
  }

  dispose() {
    _searchProducts.close();
    _allProducts.close();
    _discountProducts.close();
  }
}

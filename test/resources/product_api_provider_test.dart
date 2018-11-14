import 'package:sanne/resources/products_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('getProducts returns a list of Products', () async {
    final productsApi = ProductsApiProvider();
    productsApi.client = MockClient((request) async {
      return Response(json.encode([{'id': 123}, {'id': 456}]), 200);
    });

    final products = await productsApi.getProducts(page: 1);

    expect(products.results.length, 2);
  });

  test('getProduct returns a Product by id', () async {
    final productsApi = ProductsApiProvider();
    productsApi.client = MockClient((request) async {
      return Response(json.encode({'id': 123}), 200);
    });

    final product = await productsApi.getProduct(123);

    expect(product.id, 123);
  });
}
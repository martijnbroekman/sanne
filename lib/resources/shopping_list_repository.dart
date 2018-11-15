import 'shopping_list_db_provider.dart';
import '../models/product.dart';

class ShoppingListRepository {
  final ShoppingListDbProvider provider = shoppingListDbProvider;

  Future<List<Product>> getProducts() async {
    return await provider.getProducts();
  }

  Future<int> addProduct(Product product) {
    return provider.addProduct(product);
  }

  Future<int> removeProduct(int id) {
    return provider.removeProduct(id);
  }

  Future<int> updateProduct(Product product) {
    return provider.updateProduct(product);
  }

  Future<void> changeShoppingList(Product product) async {
    if (product.count > 0) {
      if (product.count == 1) {
        await addProduct(product);
      }
      await updateProduct(product);
    } else if (product.count == 0) {
      await removeProduct(product.id);
    }
  }

  Future<List<Product>> mergeProductsWithShoppingList(
      List<Product> products) async {
    final shoppingListProducts = await provider.getProductsPair();

    return products.map((p) {
      if (shoppingListProducts.containsKey(p.id)) {
        return shoppingListProducts[p.id];
      }
      return p;
    }).toList();
  }
}

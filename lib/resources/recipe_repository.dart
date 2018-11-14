import 'dart:async';
import 'recipe_api_provider.dart';
import 'products_api_provider.dart';
import '../models/recipe.dart';
import '../models/product.dart';

class RecipeRepository {
  final _productsApi = ProductsApiProvider();
  final _recipeApi = RecipeApiProvider();

  Future<RecipePage> getRecipes({int page = 1}) {
    return _recipeApi.getRecipes(page: page);
  }

  List<Future<Product>> getProductsForRecipe(Recipe recipe) {
    return recipe.productsIds.map((r) => _productsApi.getProduct(r)).toList();
  }
}

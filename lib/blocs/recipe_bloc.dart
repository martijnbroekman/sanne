import 'package:rxdart/rxdart.dart';
import '../models/recipe.dart';
import '../models/product.dart';

import '../resources/recipe_repository.dart';

class RecipeBloc {
  final _recipeRepository = RecipeRepository();

  final _allRecipes = BehaviorSubject<List<Recipe>>();
  final _allRecipesInput = PublishSubject<List<Recipe>>();
  final _products = BehaviorSubject<List<Future<Product>>>();

  int _maxRecipes;

  // Getters to Streams
  Observable<List<Recipe>> get recipes => _allRecipes.stream;
  Observable<List<Future<Product>>> get products => _products.stream;
  
  List<Recipe> get recipeCache => _allRecipes.stream.value;

  RecipeBloc() {
    _allRecipesInput.stream.transform(_recipesTransformer()).pipe(_allRecipes);

    _recipeRepository.getRecipes().then((recipePage) {
      _maxRecipes = recipePage.count;
      _allRecipesInput.add(recipePage.results);
    });
  }

  _recipesTransformer() {
    return ScanStreamTransformer(
      (List<Recipe> cache, List<Recipe> newRecipes, int index) {
        cache.addAll(newRecipes);
        return cache;
      },
      <Recipe>[],
    );
  }

  getProductsForRecipe(Recipe recipe) {
    _products.sink.add(_recipeRepository.getProductsForRecipe(recipe));
  }
}
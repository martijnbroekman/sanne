import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'dart:async';

import '../models/recipe.dart';

final _root = 'http://178.62.247.245:8000';

class RecipeApiProvider {
  Client client = Client();

  Future<RecipePage> getRecipes({int page = 1}) async {
    final response = await client.get('$_root/recipes/?page=$page');
    if (response.statusCode == 200) {
      final parsedJson = json.decode(response.body);
      final recipePage = RecipePage.fromJson(parsedJson);

      return recipePage;
    }
    return null;
  }
}
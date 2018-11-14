class Recipe {
  int id;
  String name;
  String preparationMethod;
  String imageUrl;
  String nutritionalValues;
  List<int> productsIds;

  Recipe.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        preparationMethod = parsedJson['preparation_method'],
        imageUrl = parsedJson['image_url'],
        nutritionalValues = parsedJson['nutritional_values'],
        productsIds = parsedJson['products'].cast<int>();
}

class RecipePage {
  int count;
  List<Recipe> results;

  RecipePage.fromJson(Map<String, dynamic> parsedJson)
      : count = parsedJson['count'],
        results = parsedJson['results']
            .map<Recipe>((r) => Recipe.fromJson(r))
            .toList();
}

class Product {
  int id;
  String name;
  double price;
  String imageUrl;
  int count;

  Product.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        imageUrl = parsedJson['image_url'],
        count = 0;
}

class ProductPage {
  int count;
  List<Product> results;

  ProductPage.fromJson(Map<String, dynamic> parsedJson)
      : count = parsedJson['count'],
        results = parsedJson['results'].map<Product>((p) => Product.fromJson(p)).toList();
}

class Product {
  int id;
  String name;
  double price;
  String imageUrl;

  Product.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        imageUrl = parsedJson['image_url'];
}

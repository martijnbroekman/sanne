class Product {
  int id;
  String name;
  double price;
  String imageUrl;
  int shelf;
  int discount;
  int count;

  double get discountPrice => price * (1 - (count / 100));

  Product.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        name = parsedJson['name'],
        price = parsedJson['price'],
        imageUrl = parsedJson['image_url'],
        shelf = parsedJson['shelf'],
        discount = parsedJson['discount'] ?? 0,
        count = parsedJson['count'] ?? 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'shelf': shelf,
      'discount': discount,
      'count': count
    };
  }
}

class ProductPage {
  int count;
  List<Product> results;

  ProductPage.fromJson(Map<String, dynamic> parsedJson)
      : count = parsedJson['count'],
        results = parsedJson['results'].map<Product>((p) => Product.fromJson(p)).toList();
}

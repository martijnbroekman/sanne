import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:collection';
import 'dart:async';

import '../models/product.dart';

class ShoppingListDbProvider {
  Database db;

  ShoppingListDbProvider() {
    init();
  }

  Future<void> init() async {
    Directory documnentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documnentsDirectory.path, 'shoppinglist.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE products
            (
              id INTEGER PRIMARY KEY,
              name TEXT,
              price REAL,
              image_url TEXT,
              shelf INTEGER,
              discount INTEGER,
              count INTEGER,
              inCart INTEGER
            )
        """);
      },
    );
  }

  Future<Product> getProduct(int id) async {
    final maps = await db.query(
      "products",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return Product.fromJson(maps.first);
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> getProductsMap() async {
    return await db.query(
      "products",
      columns: null,
    );
  }

  Future<List<Product>> getProducts() async {
    final maps = await getProductsMap();

    return maps.map((p) => Product.fromJson(p)).toList();
  }

  Future<HashMap<int, Product>> getProductsPair() async {
    final maps = await getProductsMap();

    final map = HashMap<int, Product>();
    
    if (maps.length > 0) {
      map.addEntries(maps
          .map((p) => MapEntry<int, Product>(p["id"], Product.fromJson(p))));
    }

    return map;
  }

  Future<int> addProduct(Product product) {
    return db.insert("products", product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> updateProduct(Product product) {
    return db.update(
      "products",
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  Future<int> removeProduct(int id) async {
    return db.delete(
      "products",
      where: "id =?",
      whereArgs: [id],
    );
  }
}

final shoppingListDbProvider = ShoppingListDbProvider();

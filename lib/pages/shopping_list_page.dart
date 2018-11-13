import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/ingredient.dart';
import '../pages/products_page.dart';
import '../blocs/products_provider.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShoppingListPageState();
  }
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = ProductsProvider.of(context);
    final list = bloc.shopptingList;

    return new Scaffold(
      appBar: AppBar(
        title: Text('Mijn lijst'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductsPage()));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Ingredient(
            product: list.elementAt(index),
            onProductChange: (product) {
              setState(() {
                bloc.changeShoppingList(product);
              });
            },
          );
        },
      ),
    );
  }
}

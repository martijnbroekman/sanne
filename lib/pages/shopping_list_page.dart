import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/ingredient.dart';
import '../pages/products_page.dart';

class ShoppingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: <Widget>[
          
        ],
      ),
    );
  }
}

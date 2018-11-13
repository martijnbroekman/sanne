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
          Ingredient(
            'https://static.ah.nl/image-optimization/static/product/AHI_434d50303131393337_5_LowRes_JPG.JPG?options=399,q80',
            'Boerenkool',
            count: 2,
            onAdd: () {},
            onRemove: () {},
          ),
          Ingredient(
            'https://static.ah.nl/image-optimization/static/product/AHI_434d50303131393337_5_LowRes_JPG.JPG?options=399,q80',
            'Boerenkool',
            count: 2,
            onAdd: () {},
            onRemove: () {},
          ),
        ],
      ),
    );
  }
}

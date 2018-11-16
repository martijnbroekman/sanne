import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/ingredient.dart';
import '../pages/products_page.dart';
import '../blocs/products_provider.dart';
import '../models/product.dart';

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

    return Scaffold(
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
      body: FutureBuilder(
        future: bloc.getShoppingList(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (!snapshot.hasData) {
            return Container(height: 0.0, width: 0.0,);
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Ingredient(
                product: snapshot.data[index],
                onProductChange: (product) {
                  setState(() {
                    bloc.changeShoppingList(product);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}

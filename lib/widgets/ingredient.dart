import 'package:flutter/material.dart';

import '../models/product.dart';
import '../blocs/products_provider.dart';

class Ingredient extends StatelessWidget {
  final Product product;
  final Function(Product) onProductChange;

  Ingredient({@required this.product, @required this.onProductChange});

  List<Widget> _buildChildren(ProductsBloc bloc) {
    final count = product.count;

    List<Widget> children = [
      Expanded(
        flex: 10,
        child: Text(
          product.name,
          style: TextStyle(fontSize: 12.0),
          maxLines: 2,
        ),
      )
    ];

    if (count != null && count > 0) {
      children.add(
        Container(
          margin: EdgeInsets.only(left: 5.0),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(25.0)),
          padding: EdgeInsets.symmetric(
            horizontal: 6.0,
            vertical: 2.5,
          ),
          child: Text(
            count.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 8.0,
            ),
          ),
        ),
      );
    }

    children.add(
      Expanded(
        child: SizedBox(),
      ),
    );
    if (count != null) {
      children.add(
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          color: Colors.green,
          onPressed: () {
            product.count++;
            onProductChange(product);
          },
        ),
      );

      if (count > 0) {
        children.add(
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            color: Colors.red,
            onPressed: () {
              product.count--;
              onProductChange(product);
            },
          ),
        );
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ProductsProvider.of(context);

    return ListTile(
      leading: Image.network(
        product.imageUrl,
        height: 40.0,
      ),
      title: Row(
        children: _buildChildren(bloc),
      ),
    );
  }
}

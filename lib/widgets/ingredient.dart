import 'package:flutter/material.dart';

import '../models/product.dart';
import '../blocs/products_provider.dart';

class Ingredient extends StatefulWidget {
  final Product product;
  final Function(Product) onProductChange;

  Ingredient({@required this.product, @required this.onProductChange});

  @override
  State<StatefulWidget> createState() {
    return IngredientState();
  }
}

class IngredientState extends State<Ingredient> {
  int count;

  List<Widget> _buildChildren(ProductsBloc bloc) {
    List<Widget> children = [
      Expanded(
        flex: 10,
        child: Text(
          widget.product.name,
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
            setState(() {
              widget.product.count++;
              widget.onProductChange(widget.product);
              //bloc.changeShoppingList(widget.product);
            });
          },
        ),
      );

      if (count > 0) {
        children.add(
          IconButton(
            icon: Icon(Icons.remove_circle_outline),
            color: Colors.red,
            onPressed: () {
              setState(() {
                widget.product.count--;
                widget.onProductChange(widget.product);
                //bloc.changeShoppingList(widget.product);
              });
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
    count = widget.product.count;

    return ListTile(
      leading: Image.network(
        widget.product.imageUrl,
        height: 40.0,
      ),
      title: Row(
        children: _buildChildren(bloc),
      ),
    );
  }
}

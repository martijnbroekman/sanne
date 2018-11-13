import 'package:flutter/material.dart';

import '../models/product.dart';

class Ingredient extends StatefulWidget {
  final Product product;

  Ingredient(this.product);

  @override
  State<StatefulWidget> createState() {
    return IngredientState();
  }
}

class IngredientState extends State<Ingredient> {
  int count;

  List<Widget> _buildChildren() {
    List<Widget> children = [
      Expanded(
        flex: 10,
        child: Text(
          widget.product.name,
          style: TextStyle(fontSize: 15.0),
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
    count = widget.product.count ?? 0;

    return ListTile(
      leading: Image.network(
        widget.product.imageUrl,
        height: 40.0,
      ),
      title: Row(
        children: _buildChildren(),
      ),
    );
  }
}

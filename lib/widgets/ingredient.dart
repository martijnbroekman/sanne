import 'package:flutter/material.dart';

class Ingredient extends StatelessWidget {
  final String url;
  final String text;
  final int count;
  final Function onAdd;
  final Function onRemove;

  Ingredient(this.url, this.text, {this.count, this.onAdd, this.onRemove});

  List<Widget> _buildChildren() {
    List<Widget> children = [Text(this.text)];

    if (count != null) {
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

    if (onAdd != null) {
      children.add(
        IconButton(
          icon: Icon(Icons.add_circle_outline),
          color: Colors.green,
          onPressed: onAdd,
        ),
      );
    }
    if (onRemove != null) {
      children.add(
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          color: Colors.red,
          onPressed: onRemove,
        ),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        url,
        height: 40.0,
      ),
      title: Row(
        children: _buildChildren(),
      ),
    );
  }
}

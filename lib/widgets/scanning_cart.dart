import 'package:flutter/material.dart';

import '../blocs/products_bloc.dart';
import '../models/product.dart';
import 'contained_column.dart';

class ScanningCart extends StatefulWidget {
  final ProductsBloc bloc;
  final String shelf;

  ScanningCart({@required this.bloc, this.shelf});

  @override
  State<StatefulWidget> createState() {
    return _ScanningCartState(bloc: bloc);
  }
}

class _ScanningCartState extends State<ScanningCart> {
  final ProductsBloc bloc;

  List<Product> nearby = [];

  _ScanningCartState({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: bloc.getShoppingList(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        nearby = <Product>[];
        for (var product in snapshot.data) {
          if (product.shelf == widget.shelf) {
            nearby.add(product);
          }
        }

        return ListView(
          padding: EdgeInsets.all(0.0),
          children: _buildChildren(context, snapshot.data),
        );
      },
    );
  }

  List<Widget> _buildChildren(BuildContext context, List<Product> products) {
    var widgets = <Widget>[];

    if (nearby.length > 0) {
      widgets.add(ContainedColumn(
        color: Theme.of(context).primaryColor,
        title: 'In schap',
        children: nearby
            .map(_buildTile)
            .toList(),
      ));
    }

    widgets.add(ContainedColumn(
      color: Theme.of(context).primaryColor,
      title: 'Mijn lijst',
      children: products.map(_buildTile).toList(),
    ));

    return widgets;
  }

  Widget _buildTile(Product product) {
    return ListTile(
      leading: Image.network(
        product.imageUrl,
        height: 40.0,
      ),
      title: Text(
        product.name,
        style: TextStyle(
            decoration: product.inCart
                ? TextDecoration.lineThrough
                : TextDecoration.none),
      ),
    );
  }
}

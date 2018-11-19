import 'package:flutter/material.dart';

import '../blocs/products_bloc.dart';
import '../models/product.dart';
import 'contained_column.dart';

class ScanningCart extends StatefulWidget {
  final ProductsBloc bloc;
  final int shelf;

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
        var inList = <Product>[];
        var inCart = <Product>[];

        for (var product in snapshot.data) {
          if (product.shelf == widget.shelf) {
            nearby.add(product);
          }
          if (product.inCart) {
            inCart.add(product);
          } else {
            inList.add(product);
          }
        }

        return ListView(
          padding: EdgeInsets.all(0.0),
          children: _buildChildren(inList, inCart),
        );
      },
    );
  }

  List<Widget> _buildChildren(List<Product> inList, List<Product> inCart) {
    var widgets = <Widget>[];

    if (nearby.length > 0) {
      widgets.add(ContainedColumn(
        title: 'In schap',
        children: nearby
            .map((p) => ListTile(
                  title: Text(p.name),
                ))
            .toList(),
      ));
    }

    if (inList.length > 0) {
      widgets.add(ContainedColumn(
        title: 'Mijn lijst',
        children: inList
            .map((p) => ListTile(
                  title: Text(p.name),
                ))
            .toList(),
      ));
    }

    if (inCart.length > 0) {
      widgets.add(ContainedColumn(
        title: 'Mijn winkelwagen',
        children: inCart
            .map((p) => ListTile(
                  title: Text(p.name),
                ))
            .toList(),
      ));
    }

    return widgets;
  }
}

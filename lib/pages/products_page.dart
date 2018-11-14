import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart' show PagewiseListView;

import '../widgets/ingredient.dart';
import '../widgets/search_app_bar.dart';
import '../widgets/product_list.dart';
import '../blocs/products_provider.dart';
import '../models/product.dart';

class ProductsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductsPage> {
  bool searchEnabled = false;

  @override
  Widget build(BuildContext context) {
    final bloc = ProductsProvider.of(context);

    return new Scaffold(
      appBar: SearchAppBar(
        title: 'Producten',
        searchText: 'Zoek een product',
        onInput: (String value) {
          bloc.getProductByKeyWord(value);
        },
        onInputEnabled: (bool enabled) {
          if (enabled != searchEnabled) {
            setState(() {
              searchEnabled = enabled;
            });
          }
        },
      ),
      body: searchEnabled
          ? buildSearchList(bloc)
          : ProductList(
              bloc: bloc,
            ),
    );
  }

  Widget buildSearchList(ProductsBloc bloc) {
    return StreamBuilder(
      stream: bloc.foundProducts,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            final product = snapshot.data[index];

            return Ingredient(
              product: product,
              onProductChange: (product) {
                setState(() {
                  bloc.changeShoppingList(product);
                });
              },
            );
          },
        );
      },
    );
  }
}

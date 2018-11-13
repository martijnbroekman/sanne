import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/ingredient.dart';
import '../widgets/search_app_bar.dart';
import '../blocs/products_provider.dart';
import '../models/product.dart';

class ProductsPage extends StatelessWidget {
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
      ),
      body: buildSearchList(bloc),
    );
  }

  Widget buildSearchList(ProductsBloc bloc) {
    return StreamBuilder(
      stream: bloc.foundProducts,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Still loading');
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            final product = snapshot.data[index];
            
            return Ingredient(product.imageUrl, product.name);
          },
        );
      },
    );
  }
}

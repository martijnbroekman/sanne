import 'package:flutter/material.dart';
import '../blocs/products_provider.dart';
import '../models/product.dart';
import './ingredient.dart';

class ProductList extends StatefulWidget {
  final ProductsBloc bloc;

  ProductList({this.bloc});

  @override
  State<StatefulWidget> createState() => _ProductListState(bloc: bloc);
}

class _ProductListState extends State<ProductList> {
  final ProductsBloc bloc;

  _ProductListState({this.bloc});

  int pageNumber = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    bloc.getProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageNumber++;
        bloc.getProducts();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildList(bloc, _scrollController);
  }

  Widget buildList(ProductsBloc bloc, ScrollController scrollController) {
    return StreamBuilder(
      stream: bloc.allProducts,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        print('products count: ${snapshot.data.length}');
        return ListView.builder(
          controller: scrollController,
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
    );
  }
}

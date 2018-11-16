import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../blocs/products_provider.dart';
import '../widgets/ingredient.dart';

class DiscountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ProductsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('In de aanbieding'),
      ),
      body: _DiscountList(
        bloc: bloc,
      ),
    );
  }
}

class _DiscountList extends StatefulWidget {
  final ProductsBloc bloc;

  _DiscountList({@required this.bloc});

  @override
  State<StatefulWidget> createState() {
    return _DiscountListState(bloc: bloc);
  }
}

class _DiscountListState extends State<_DiscountList> {
  final ProductsBloc bloc;

  _DiscountListState({@required this.bloc});

  @override
  void initState() {
    bloc.getDiscounts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.discountProducts,
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return Ingredient(
              product: snapshot.data[index],
              onProductChange: (Product product) {
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

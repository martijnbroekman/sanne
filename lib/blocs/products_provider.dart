import 'package:flutter/material.dart';
import 'products_bloc.dart';

export 'products_bloc.dart';

class ProductsProvider extends InheritedWidget {
  final ProductsBloc productsBloc;

  ProductsProvider({Key key, Widget child})
      : productsBloc = ProductsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ProductsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ProductsProvider)
            as ProductsProvider)
        .productsBloc;
  }
}

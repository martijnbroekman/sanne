import 'package:flutter/material.dart';
import 'recipe_bloc.dart';

export 'recipe_bloc.dart';

class RecipeProvider extends InheritedWidget {
  final RecipeBloc recipeBloc;

  RecipeProvider({Key key, Widget child})
      : recipeBloc = RecipeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static RecipeBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(RecipeProvider)
            as RecipeProvider)
        .recipeBloc;
  }
}

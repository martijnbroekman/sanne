import 'package:flutter/material.dart';

import '../blocs/recipe_bloc.dart';
import '../models/recipe.dart';
import 'recipe_list_item.dart';

class RecipeList extends StatelessWidget {
  final RecipeBloc bloc;

  RecipeList(this.bloc);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.recipes,
      initialData: bloc.recipeCache,
      builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeListItem(snapshot.data[index]);
          },
        );
      },
    );
  }
}

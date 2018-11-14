import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../blocs/recipe_provider.dart';
import '../widgets/recipe_list.dart';

class RecipesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Recepten'),
      ),
      body: RecipeList(bloc),
    );
  }
}

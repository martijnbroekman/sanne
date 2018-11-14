import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeListItem extends StatelessWidget {
  final Recipe recipe;

  RecipeListItem(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Image.network(recipe.imageUrl),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[Text(recipe.name)],
                ),
              ),
            )
          ],
        ),
        onTap: () {},
      ),
    );
  }
}

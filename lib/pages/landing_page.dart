import 'package:flutter/material.dart';

import '../pages/recipe_details_page.dart';
import '../blocs/recipe_provider.dart';
import '../models/recipe.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = RecipeProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Discover weekly'),
      ),
      body: StreamBuilder(
        stream: bloc.recipes,
        initialData: bloc.recipeCache,
        builder: (BuildContext context, AsyncSnapshot<List<Recipe>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 0.0,
              width: 0.0,
            );
          }

          return OrientationBuilder(
            builder: (context, orientation) {
              return GridView.count(
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                children: _buildChildren(context, snapshot.data),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context, List<Recipe> recipes) {
    return recipes
        .map((r) => Card(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(r.imageUrl),
                  ),
                ),
                child: InkWell(
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          r.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                blurRadius: 1.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => RecipeDetailsPage(recipe: r)));
                  },
                ),
              ),
            ))
        .toList();
  }
}

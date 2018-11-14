import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsPage({@required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              title: Text(
                'Details',
              ),
              flexibleSpace: FlexibleSpaceBar(
                // Kijken hoe text afsnijden werkt
                // centerTitle: true,
                // title: Text(
                //   recipe.name,
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 16.0,
                //   ),
                //   overflow: TextOverflow.fade,
                // ),
                background: Image.network(
                  recipe.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Padding(
                child: Text(
                  recipe.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                padding: EdgeInsets.only(bottom: 10.0),
              ),
              _buildPreparationMethod(),
              _buildNutritionalValues(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreparationMethod() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Bereiden',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          _formatText(recipe.preparationMethod),
        ],
      ),
    );
  }

  Widget _buildNutritionalValues() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Voerdingwaarden',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          _formatText(recipe.nutritionalValues),
        ],
      ),
    );
  }

  Widget _formatText(String text) {
    return Text(text.replaceAll('\n ', '\n'));
  }
}

class _RecipeDetailsProductList extends StatefulWidget {

  final Recipe recipe;

  _RecipeDetailsProductList(this.recipe);

  @override
  State<StatefulWidget> createState() {
    return _RecipeDetailsProductListState();
  }
}

class _RecipeDetailsProductListState extends State<_RecipeDetailsProductList> {
  @override
  Widget build(BuildContext context) {
    // I don't tink i'll need a listview because of the listview in the paren
    return Column();
  }
}

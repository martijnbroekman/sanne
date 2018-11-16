import 'package:flutter/material.dart';

import '../models/recipe.dart';
import '../models/product.dart';
import '../blocs/recipe_provider.dart';
import '../widgets/ingredient.dart';

class RecipeDetailsPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailsPage({@required this.recipe});

  @override
  Widget build(BuildContext context) {
    final bloc = RecipeProvider.of(context);

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
              _RecipeDetailsProductList(
                recipe: recipe,
                bloc: bloc,
              ),
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
  final RecipeBloc bloc;

  _RecipeDetailsProductList({this.recipe, this.bloc});

  @override
  State<StatefulWidget> createState() {
    return _RecipeDetailsProductListState(recipe: recipe, bloc: bloc);
  }
}

class _RecipeDetailsProductListState extends State<_RecipeDetailsProductList> {
  final Recipe recipe;
  final RecipeBloc bloc;

  _RecipeDetailsProductListState({this.recipe, this.bloc});

  @override
  void initState() {
    bloc.getProductsForRecipe(recipe);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildProducts();
  }

  Widget _buildProducts() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'ingrediënten',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          StreamBuilder(
            stream: bloc.products,
            builder: (
              BuildContext context,
              AsyncSnapshot<List<Product>> snapshot,
            ) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              return Column(
                children: List.generate(
                  snapshot.data.length,
                  (int index) {
                    return Ingredient(
                      product: snapshot.data[index],
                      onProductChange: (value) {
                        setState(() {
                          bloc.changeShoppingList(snapshot.data[index]);
                        });
                      },
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

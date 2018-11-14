import 'package:flutter/material.dart';

import 'package:sanne/pages/landing_page.dart';
import 'package:sanne/pages/discount_page.dart';
import 'package:sanne/pages/shopping_list_page.dart';
import 'package:sanne/pages/recipes_page.dart';

import 'package:sanne/widgets/fab_bottom_app_bar.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DashboardPageState();
  }
}

class _DashboardPageState extends State<DashboardPage> {
  PageController _pageController;
  int _page = 0;

  void _navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          LandingPage(),
          DiscoundPage(),
          ShoppingListPage(),
          RecipesPage()
        ],
        onPageChanged: _onPageChanged,
        controller: _pageController,
      ),
      bottomNavigationBar: FABBottomAppBar(
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: _navigationTapped,
        items: <FABBottomAppBarItem>[
          FABBottomAppBarItem(iconData: Icons.lightbulb_outline, text: 'Ontdek'),
          FABBottomAppBarItem(iconData: Icons.local_offer, text: 'Korting'),
          FABBottomAppBarItem(iconData: Icons.assignment, text: 'Mijn lijst'),
          FABBottomAppBarItem(iconData: Icons.restaurant, text: 'Recepten'),
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.pushNamed(context, '/scanning');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

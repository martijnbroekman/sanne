import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String searchText;
  final Function(String) onInput;
  final Function(bool) onInputEnabled;

  SearchAppBar({this.title, this.searchText, this.onInput, this.onInputEnabled});

  @override
  _SearchAppBarState createState() => new _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  Widget appBarTitle = Text('Products');
  Icon actionIcon = Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (actionIcon.icon == Icons.search) {
                actionIcon = Icon(Icons.close);
                appBarTitle = TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: widget.searchText,
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: widget.onInput,
                );
                widget.onInputEnabled(true);
              } else {
                actionIcon = Icon(Icons.search);
                appBarTitle = Text(widget.title);
                widget.onInputEnabled(false);
              }
            });
          },
        ),
      ],
    );
  }
}

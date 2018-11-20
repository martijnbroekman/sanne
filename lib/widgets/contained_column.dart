import 'package:flutter/material.dart';

class ContainedColumn extends StatelessWidget {
  final String title;
  final Color color;
  final List<Widget> children;

  ContainedColumn(
      {@required this.title,
      @required this.children,
      this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DecoratedBox(
          decoration: new BoxDecoration(
            color: color,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black,
                offset: Offset(1.0, 1.0),
                blurRadius: 5.0,
              ),
            ],
          ),
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Column(
          children: children,
        )
      ],
    );
  }
}

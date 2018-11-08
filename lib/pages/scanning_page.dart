import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import 'package:sanne/widgets/contained_column.dart';

class ScanningPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScanningPageState();
  }
}

class _ScanningPageState extends State<ScanningPage> {
  String qr = '';
  int timesChecked = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new QrCamera(
                onError: (context, error) => Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                qrCodeCallback: (code) {
                  if (code == qr || qr == '') {
                    timesChecked++;
                    if (timesChecked < 4 || timesChecked > 4) {
                      return;
                    }
                  } else {
                    timesChecked = 0;
                    return;
                  }

                  setState(() {
                    qr = code;
                  });

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Text(qr),
                      );
                    },
                  ).then((dynamic value) {
                    timesChecked = 0;
                  });
                }),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              padding: EdgeInsets.all(0.0),
              children: <Widget>[
                ContainedColumn(
                  title: 'Mijn lijst',
                  children: <Widget>[
                    ListTile(title: Text('Pinda\'s'),),
                    ListTile(title: Text('Appels'),),
                    ListTile(title: Text('Brood'),),
                    ListTile(title: Text('Koffie'),),
                    ListTile(title: Text('Zeep'),),
                    ListTile(title: Text('Zalm'),),
                    ListTile(title: Text('Chips'),)
                  ],
                ),
                ContainedColumn(
                  title: 'Mijn winkelwagen',
                  children: <Widget>[
                    ListTile(title: Text('bananen'),)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

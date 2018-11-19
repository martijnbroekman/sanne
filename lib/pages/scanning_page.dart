import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:beacons/beacons.dart';
import 'dart:async';

import '../blocs/products_provider.dart';
import '../widgets/scanning_cart.dart';
import '../models/product.dart';

class ScanningPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScanningPageState();
  }
}

class _ScanningPageState extends State<ScanningPage> {
  String qr = '';
  int timesChecked = 0;

  StreamSubscription<RangingResult> _subscription;
  int _subscriptionStartedTimestamp;
  int _shelf = 0;

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  void initState() {
    _subscriptionStartedTimestamp = DateTime.now().millisecondsSinceEpoch;
    _subscription = Beacons.ranging(
      region: BeaconRegion(
        identifier: 'sanne beacon',
        ids: ['905d6772-3d51-41c9-b95b-c79ee0545ad4'],
      ),
      inBackground: true,
    ).listen(
      (RangingResult result) {
        int shelf = 0;
        if (result.isNotEmpty) {
          shelf = result.beacons.first.ids.first ==
                  '905d6772-3d51-41c9-b95b-c79ee0545ad4'
              ? 1
              : 2;
          print(shelf);
        }
        if (_shelf != shelf) {
          setState(() {
            _shelf = shelf;
          });
        }
      },
    )..onError((error) {
        print(error);
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = ProductsProvider.of(context);

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
            child: ScanningCart(
              bloc: bloc,
              shelf: _shelf,
            ),
          ),
        ],
      ),
    );
  }
}

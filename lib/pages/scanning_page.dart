import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:beacons/beacons.dart';
import 'dart:async';

import '../blocs/products_provider.dart';
import '../widgets/scanning_cart.dart';
import '../widgets/scanning_camera.dart';
import '../models/product.dart';

class ScanningPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScanningPageState();
  }
}

class _ScanningPageState extends State<ScanningPage> {
  StreamSubscription<RangingResult> _subscription;
  int _subscriptionStartedTimestamp;
  String _shelf = '';

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
        ids: [
          // 'c336aa38-54bb-483b-ae75-3ba707855035',
          // '905d6772-3d51-41c9-b95b-c79ee0545ad4'
        ],
      ),
      inBackground: true,
    ).listen(
      (RangingResult result) {
        String shelf = '';
        if (result.isNotEmpty) {
          Beacon closedBeacon;
          for (Beacon beacon in result.beacons) {
            if (closedBeacon == null) {
              closedBeacon = beacon;
            } else if (closedBeacon.distance > beacon.distance) {
              closedBeacon = beacon;
            }
          }
          shelf = closedBeacon.ids.first;
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
            child: ScanningCamera(
              bloc: bloc,
              onAddProduct: (Product product) {
                product.inCart = true;
                product.count++;
                bloc.changeShoppingList(product);
                setState(() {});
              },
            ),
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

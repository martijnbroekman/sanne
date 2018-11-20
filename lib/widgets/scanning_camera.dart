import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import '../blocs/products_bloc.dart';
import '../models/product.dart';

class ScanningCamera extends StatefulWidget {
  final ProductsBloc bloc;
  final Function(Product) onAddProduct;

  ScanningCamera({@required this.bloc, @required this.onAddProduct});

  @override
  State<StatefulWidget> createState() {
    return _ScanningCameraState(bloc: bloc);
  }
}

class _ScanningCameraState extends State<ScanningCamera> {
  final ProductsBloc bloc;
  String qr = '';
  int timesChecked = 0;

  _ScanningCameraState({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return QrCamera(
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
          setState(() {
            timesChecked = 0;
            qr = code;
          });

          return;
        }

        setState(() {
          qr = code;
        });

        bloc.getProduct(int.parse(code)).then((Product product) {
          showDialog(
            context: context,
            builder: (context) {
              return _buildModal(context, product);
            },
          ).then((value) {
            setState(() {
              timesChecked = 0;
            });
          });
        });
      },
    );
  }

  Widget _buildModal(BuildContext context, Product product) {
    return AlertDialog(
      title: Text('Wilt u het volgende product toevoegen aan uw winkelwagen'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.network(product.imageUrl),
          Text(product.name),
          SizedBox(height: 10.0,),
          Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
              child: Text('Ja!'),
              onPressed: () {
                setState(() {
                  timesChecked = 0;
                });
                Navigator.pop(context);
                widget.onAddProduct(product);
              },
            ),
            FlatButton(
              child: Text('Nee'),
              onPressed: () {
                setState(() {
                  timesChecked = 0;
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
        ],
      ),
    );
  }
}

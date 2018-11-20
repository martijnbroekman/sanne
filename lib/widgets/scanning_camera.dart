import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import '../blocs/products_bloc.dart';
import '../models/product.dart';

class ScanningCamera extends StatefulWidget {
  final ProductsBloc bloc;

  ScanningCamera({@required this.bloc});

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
          showBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildModal(context, product);
            },
          ).closed.then((v) {
            setState(() {
              timesChecked = 0;
            });
          });
          // showModalBottomSheet(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return _buildModal(product);
          //   },
          // ).then(
          //   (dynamic value) {
          //     setState(() {
          //       timesChecked = 0;
          //     });
          //   },
          // );
        });
      },
    );
  }

  Widget _buildModal(BuildContext context, Product product) {
    return Container(
      height: 200,
      child: Column(
        children: <Widget>[
          Image.network(product.imageUrl),
          Text(product.name),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("Aan wikelwagen"),
                onPressed: () {
                  setState(() {
                    timesChecked = 0;
                  });
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Aan Boodschappenlijst"),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

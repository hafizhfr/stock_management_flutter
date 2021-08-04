import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatefulWidget {
  @override
  _ProductCardWidget createState() => _ProductCardWidget();
}

class _ProductCardWidget extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
          elevation: 1.5,
          color: Colors.white,
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Image.asset(
                        'images/signup_illustration.jpg',
                        height: 48,
                        width: 48,
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Product Name",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Price",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            "Stock",
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ))
                ],
              ))),
    );
  }
}

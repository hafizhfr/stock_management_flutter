import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatefulWidget {
  final String productImg;
  final String productName;
  final int productPrice;
  final int productStock;
  ProductCardWidget(
      this.productImg, this.productName, this.productPrice, this.productStock);
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
                    // flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          // "Product Name",
                          widget.productName,
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          // "Price",
                          'Rp ' + widget.productPrice.toString(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          // "Stock",
                          'Stok: ' + widget.productStock.toString(),
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: Icon(Icons.edit), onPressed: () {}),
                        IconButton(icon: Icon(Icons.delete), onPressed: () {}),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

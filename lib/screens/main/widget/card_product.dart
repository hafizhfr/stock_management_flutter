import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/screens/main/frame/edit_item_screen.dart';
import 'package:stock_management_flutter/screens/main/widget/alert_dialog.dart';

class ProductCardWidget extends StatefulWidget {
  final String productImg;
  final String productName;
  final String productCategory;
  final int productPrice;
  final int productStock;
  ProductCardWidget(this.productImg, this.productName, this.productCategory,
      this.productPrice, this.productStock);
  @override
  _ProductCardWidget createState() => _ProductCardWidget();
}

class _ProductCardWidget extends State<ProductCardWidget> {
  AlertDialogController alertController =
      AlertDialogController(isConfirmed: true);
  final User? user = FirebaseServices.user;
  final ItemsController _itemsController = Get.find();
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
                  FittedBox(
                    child: Image.network(
                      widget.productImg,
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          // "Price",
                          'Rp ' + widget.productPrice.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          // "Stock",
                          'Stok: ' + widget.productStock.toString(),
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditItemScreen(
                                          widget.productName,
                                          widget.productCategory,
                                          widget.productPrice,
                                          widget.productStock,
                                          widget.productImg)));
                            }),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialogDeleteWidget(
                                        alertController);
                                  });
                              print(alertController.isConfirmed);
                              if (alertController.isConfirmed) {
                                _itemsController.deleteItem(
                                    widget.productName, widget.productStock);
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}

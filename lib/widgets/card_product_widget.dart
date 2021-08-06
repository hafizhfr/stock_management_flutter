import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_management_flutter/page/edit_item_screen.dart';
import 'package:stock_management_flutter/widgets/alert_dialog_widget.dart';

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
  AlertDialogController alertController = AlertDialogController();
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
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditItemScreen(widget.productName)));
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
                                setState(() {
                                  _deleteItem(widget.productName);
                                  Fluttertoast.showToast(
                                      msg:
                                          'Berhasil menghapus ${widget.productName}',
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      fontSize: 16.0);
                                });
                              }
                            }),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }

  Future<void> _deleteItem(String itemName) async {
    CollectionReference itemCollection =
        FirebaseFirestore.instance.collection('items');

    var filteredDocumentByName =
        await itemCollection.where('namaBarang', isEqualTo: itemName).get();
    for (var doc in filteredDocumentByName.docs) {
      await doc.reference.delete();
    }
  }
}

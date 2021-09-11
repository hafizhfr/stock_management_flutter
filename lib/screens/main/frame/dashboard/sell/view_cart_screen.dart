import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/screens/main/main_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final items = List<String>.generate(3, (i) => "Item $i");
  ItemsController _itemsController = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Text(
                    "Item Name",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.grey),
                    textAlign: TextAlign.start,
                  )),
                  Expanded(
                      child: Text(
                    "QTY",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "Price",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .apply(color: Colors.grey),
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              flex: 8,
              child: FutureBuilder<List>(
                future: _itemsController.getCart(),
                builder: (contex, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  snapshot.data![i]['name'],
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data![i]['count'].toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Rp ${snapshot.data![i]['price'].toString()}',
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          );
                        });
                  } else {
                    return Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
              // child: ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: items.length,
              //   itemBuilder: (context, index) {
              //     return Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: <Widget>[
              //             Expanded(
              //               child: Text(
              //                 "name",
              //                 style: Theme.of(context).textTheme.bodyText1,
              //                 textAlign: TextAlign.start,
              //               ),
              //             ),
              //             Expanded(
              //                 child: Text(
              //               "qty",
              //               style: Theme.of(context).textTheme.bodyText1,
              //               textAlign: TextAlign.center,
              //             )),
              //             Expanded(
              //                 child: Text(
              //               "Rp. amount",
              //               style: Theme.of(context).textTheme.bodyText1,
              //               textAlign: TextAlign.end,
              //             )),
              //           ],
              //         ),
              //         SizedBox(
              //           height: 16,
              //         ),
              //         Container(
              //           width: size.width,
              //           height: 1,
              //           color: Colors.amber,
              //         ),
              //         SizedBox(
              //           height: 16,
              //         )
              //       ],
              //     );
              //   },
              // ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 0,
                      width: 0,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Total",
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  // ngeloop list abis itu ditampilin
                  Expanded(
                    child: Obx(
                      () => Text(
                        "Rp. ${_itemsController.totalPrice}",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  width: size.width * 2 / 3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.grey)))),
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      _itemsController.confirmCart();
                      Fluttertoast.showToast(
                          msg: 'Transaksi Berhasil',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    },
                  ),
                )),
            SizedBox(
              height: 12,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  height: 50,
                  width: size.width * 2 / 3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.amber)))),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async {
                      await _itemsController.cancelCart();
                      Fluttertoast.showToast(
                          msg: 'Berhasil Menghapus Stock',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

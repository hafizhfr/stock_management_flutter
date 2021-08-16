import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/page/cart_screen.dart';
import 'package:stock_management_flutter/widgets/dropdown_product_widget.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  _AddToCartScreen createState() => _AddToCartScreen();
}

class _AddToCartScreen extends State<AddToCartScreen> {
  final itemProductCountController = TextEditingController();
  ItemProductController itemProductController = ItemProductController(itemProduct: 'Makanan');

  String kategori = '';

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference itemCollection = firestore.collection('items');

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add To Cart"),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Nama Item",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 8,),
                Flexible(
                    child: DropDownProductWidget(
                      itemProductController,
                    )),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Jumlah Item",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 8,),
                Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: itemProductCountController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          // labelText: "Jumlah Item"
                      ),
                    )),
                SizedBox(
                  height: 32,
                ),
                Flexible(
                    child: Container(
                      height: 50,
                      width: itemWidth / 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.grey)))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Add To Cart',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.black,
                              )
                            ]),
                        onPressed: () {
                          if (itemProductCountController.text.isEmpty) {
                            setState(() {
                              _validate = true;
                            });
                          } else {
                            // itemCollection.add({
                            //   'namaBarang': itemNameController.text,
                            //   'jumlahBarang':
                            //   int.tryParse(itemProductCountController.text),
                            //   'hargaBarang': int.tryParse(itemPriceController.text),
                            //   'kategori': itemProductController.itemProduct,
                            // });

                            itemProductCountController.text = '';
                            Fluttertoast.showToast(
                                msg: 'Berhasil menambahkan barang ke keranjang',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16.0);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              _validate = false;
                              return CartScreen();
                            }));
                          }
                        },
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    itemProductCountController.dispose();
    super.dispose();
  }
}

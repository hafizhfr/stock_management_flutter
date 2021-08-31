import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/item.dart';
import 'package:stock_management_flutter/items_list.dart';
import 'package:stock_management_flutter/page/cart_screen.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:stock_management_flutter/widgets/dropdown_product_widget.dart';
import 'package:provider/provider.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  _AddToCartScreen createState() => _AddToCartScreen();
}

class _AddToCartScreen extends State<AddToCartScreen> {
  final productNameController = TextEditingController();
  final productCountController = TextEditingController();
  ItemProductController itemProductController =
      ItemProductController(itemProduct: 'Makanan');

  bool _validate = false;
  List a = [];
  List<String> itemNameList = [];
  String selectedProductName;
  String selectedProductCount;

  @override
  void initState() {
    ItemList.getItemListOnce().then((value) => a = value);

    super.initState();
  }

  void addToList() {
    a.forEach((element) {
      itemNameList.add(element.namaBarang);
      print(a.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
    if (itemNameList.length == 0) {
      addToList();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Add To Cart"),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              // key: this._formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   "Nama Item",
                  //   style: Theme.of(context).textTheme.subtitle1,
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  Container(
                    child: TypeAheadFormField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: productNameController,
                        decoration: InputDecoration(
                          labelText: 'Nama Item',
                          border: OutlineInputBorder(),
                          errorText:
                              _validate ? 'Nama item tidak boleh kosong' : null,
                        ),
                      ),
                      noItemsFoundBuilder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Item tidak ditemukan'),
                      ),
                      suggestionsCallback: (pattern) => itemNameList.where(
                        (element) => element.toLowerCase().contains(
                              pattern.toLowerCase(),
                            ),
                      ),
                      itemBuilder: (_, String productName) => ListTile(
                        title: Text(productName),
                      ),
                      onSuggestionSelected: (String selectedVal) {
                        this.productNameController.text = selectedVal;
                        print(selectedVal);
                      },
                      onSaved: (value) => this.selectedProductName = value,
                      getImmediateSuggestions: false,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: TextField(
                    keyboardType: TextInputType.number,
                    controller: productCountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      errorText:
                          _validate ? 'Jumlah item tidak boleh kosong' : null,
                      labelText: 'Jumlah Item',
                    ),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Flexible(
                    child: Container(
                      height: 50,
                      width: itemWidth / 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                          if (productCountController.text.isEmpty) {
                            setState(() {
                              _validate = true;
                            });
                          } else {
                            setState(() {
                              _validate = false;
                            });
                            // itemCollection.add({
                            //   'namaBarang': itemNameController.text,
                            //   'jumlahBarang':
                            //   int.tryParse(itemProductCountController.text),
                            //   'hargaBarang': int.tryParse(itemPriceController.text),
                            //   'kategori': itemProductController.itemProduct,
                            // });
                            productCountController.text = '';
                            Fluttertoast.showToast(
                                msg: 'Berhasil menambahkan barang ke keranjang',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                fontSize: 16.0);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                _validate = false;
                                return CartScreen();
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    productNameController.dispose();
    productCountController.dispose();
    super.dispose();
  }
}

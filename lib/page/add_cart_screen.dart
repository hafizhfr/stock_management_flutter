import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/firebase_config/cart_db.dart';
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

  bool _itemNameValidate = false;
  bool _itemCountValidate = false;

  List tempItemList = [];
  List<String> itemNameList = [];
  List<int> itemPriceList = [];

  int selectedProductPrice;

  @override
  void initState() {
    ItemList.getItemListOnce().then((value) => tempItemList = value);

    super.initState();
  }

  void addToList() {
    tempItemList.forEach((element) {
      itemNameList.add(element.namaBarang);
      itemPriceList.add(element.hargaBarang);
      // print(a.length);
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
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                // key: this._formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: productNameController,
                          decoration: InputDecoration(
                            labelText: 'Nama Item',
                            border: OutlineInputBorder(),
                            errorText: _itemNameValidate
                                ? 'Nama item tidak boleh kosong'
                                : null,
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
                          int selectedIndex = itemNameList.indexOf(selectedVal);
                          if (selectedIndex != -1) {
                            this.productNameController.text = selectedVal;
                            this.selectedProductPrice =
                                itemPriceList[selectedIndex];
                            print(selectedVal);
                          }
                        },
                        onSaved: (value) {},
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
                          errorText: _itemCountValidate
                              ? 'Jumlah item tidak boleh kosong'
                              : null,
                          labelText: 'Jumlah Item',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: itemWidth / 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
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
                              _itemCountValidate = true;
                            });
                          }
                          if (productNameController.text.isEmpty) {
                            setState(() {
                              _itemNameValidate = true;
                            });
                          }
                          if (productCountController.text.isNotEmpty &&
                              productNameController.text.isNotEmpty) {
                            _itemNameValidate = false;
                            _itemCountValidate = false;

                            Cart.addToDB(
                              productNameController.text,
                              int.tryParse(productCountController.text),
                              selectedProductPrice,
                            );
                            Fluttertoast.showToast(
                              msg: 'Berhasil menambahkan barang ke keranjang',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            productNameController.text = '';
                            productCountController.text = '';
                          }
                          // itemCollection.add({
                          //   'namaBarang': itemNameController.text,
                          //   'jumlahBarang':
                          //   int.tryParse(itemProductCountController.text),
                          //   'hargaBarang': int.tryParse(itemPriceController.text),
                          //   'kategori': itemProductController.itemProduct,
                          // });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      width: itemWidth / 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                _itemNameValidate = false;
                                _itemCountValidate = false;
                                return CartScreen();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'View Cart',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
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

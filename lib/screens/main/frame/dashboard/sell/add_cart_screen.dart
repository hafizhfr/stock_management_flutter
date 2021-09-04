import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/data/models/item_model.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/sell/view_cart_screen.dart';

class AddToCartScreen extends StatefulWidget {
  @override
  _AddToCartScreen createState() => _AddToCartScreen();
}

class _AddToCartScreen extends State<AddToCartScreen> {
  final productNameController = TextEditingController();
  final productCountController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ItemsController _itemsController = Get.find();

  late int selectedProductPrice;
  late int selectedProductCount;
  late String selectedProductCat;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;
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
                key: _formKey,
                child: FutureBuilder(
                  future: _itemsController.getItemList(),
                  builder: (contex, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
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
                                ),
                              ),
                              noItemsFoundBuilder: (context) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Item tidak ditemukan'),
                              ),
                              suggestionsCallback: (pattern) =>
                                  _itemsController.itemNameList.where(
                                (element) => element.toLowerCase().contains(
                                      pattern.toLowerCase(),
                                    ),
                              ),
                              itemBuilder: (_, String productName) => ListTile(
                                title: Text(productName),
                              ),
                              onSuggestionSelected: (String selectedVal) {
                                int selectedIndex = _itemsController
                                    .itemNameList
                                    .indexOf(selectedVal);
                                if (selectedIndex != -1) {
                                  var data = snapshot.data as List<Item>;
                                  this.productNameController.text = selectedVal;
                                  this.selectedProductPrice = _itemsController
                                      .itemPriceList[selectedIndex];
                                  this.selectedProductCount = _itemsController
                                      .itemCountList[selectedIndex];
                                  this.selectedProductCat =
                                      data[selectedIndex].kategori;
                                }
                              },
                              onSaved: (value) {},
                              getImmediateSuggestions: false,
                              validator: (value) {
                                if (value == null || value == '') {
                                  return 'Nama item tidak boleh kosong';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: productCountController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Jumlah Item',
                              ),
                              validator: (value) {
                                if (value == null || value == '') {
                                  return "Jumlah item tidak boleh kosong";
                                }
                                if (int.parse(value) >
                                    this.selectedProductCount) {
                                  return "Stock item tidak mencukupi";
                                }
                              },
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
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                                if (_formKey.currentState!.validate()) {
                                  _itemsController.addCart(
                                      productNameController.text,
                                      this.selectedProductCat,
                                      this.selectedProductPrice,
                                      int.parse(productCountController.text),
                                      this.selectedProductCount);

                                  Fluttertoast.showToast(
                                    msg:
                                        'Berhasil menambahkan barang ke keranjang',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    fontSize: 16.0,
                                  );
                                  productNameController.text = '';
                                  productCountController.text = '';
                                }
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
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.grey),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.to(() => CartScreen());
                              },
                              child: Text(
                                'View Cart',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
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

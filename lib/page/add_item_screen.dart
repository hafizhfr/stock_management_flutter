import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stock_management_flutter/firebase_config/auth_services.dart';
import 'package:stock_management_flutter/firebase_config/dashboard_item_status_db.dart';
import 'package:stock_management_flutter/firebase_config/history_db.dart';
import 'package:stock_management_flutter/page/dashboard_screen.dart';
import 'package:stock_management_flutter/widgets/dropdown_category_widget.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreen createState() => _AddItemScreen();
}

class _AddItemScreen extends State<AddItemScreen> {
  File _image;
  final itemNameController = TextEditingController();
  final itemCountController = TextEditingController();
  final itemPriceController = TextEditingController();
  final User user = AuthServices.getUser();

  ItemCategoryController itemCategoryController =
      ItemCategoryController(itemCategory: 'Makanan');

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference itemCollection = firestore.collection('items');
    CollectionReference historyCollection = firestore.collection('history');

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          // ClampingScrollPhysics(parent: NeverScrollableScrollPhysics()),
          // child: Padding(
          //   padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.grey,
                // padding: EdgeInsets.all(48),
                child: IconButton(
                  iconSize: 150,
                  icon: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.white,
                    size: 36,
                  ),
                  onPressed: () {
                    //image picker
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Nama Item"),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: itemCountController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "Jumlah Item"),
              ),
              SizedBox(
                height: 15,
              ),
              dropDown(),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: itemPriceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixText: "Rp. ",
                    labelText: "Harga Per Item"),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 50,
                    width: itemWidth / 3,
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
                              'Simpan',
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.save,
                            )
                          ]),
                      onPressed: () {
                        if (itemNameController.text.isEmpty ||
                            itemCountController.text.isEmpty ||
                            itemPriceController.text.isEmpty ||
                            itemCategoryController.itemCategory == '') {
                          Fluttertoast.showToast(
                            msg:
                                'Gagal menambahkan barang. Seluruh kolom harus diisi.',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0,
                          );
                          setState(() {
                            _validate = true;
                          });
                        } else {
                          itemCollection.add({
                            'namaBarang':
                                StringUtils.capitalize(itemNameController.text),
                            'jumlahBarang':
                                int.tryParse(itemCountController.text),
                            'hargaBarang':
                                int.tryParse(itemPriceController.text),
                            'kategori': itemCategoryController.itemCategory,
                          });

                          HistoryCollection.addToDB(
                              itemNameController.text, user.displayName, 1);

                          ItemStatus.updateTotalStock(
                              int.tryParse(itemCountController.text), 0);

                          Fluttertoast.showToast(
                            msg: 'Berhasil menambahkan barang',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0,
                          );
                          itemNameController.clear();
                          itemCountController.clear();
                          itemPriceController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    itemNameController.dispose();
    itemCountController.dispose();
    itemPriceController.dispose();
    super.dispose();
  }

  Widget dropDown() => DropDownCategoryWidget(
        controller: itemCategoryController,
        screenType: 1,
        onSelected: () {
          setState(() {});
        },
      );
}

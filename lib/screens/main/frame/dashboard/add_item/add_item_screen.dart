import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/add_item_controller.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/screens/main/widget/dropdown_category.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreen createState() => _AddItemScreen();
}

class _AddItemScreen extends State<AddItemScreen> {
  final itemNameController = TextEditingController();
  final itemCountController = TextEditingController();
  final itemPriceController = TextEditingController();
  final User? user = FirebaseServices.user;

  ItemCategoryController itemCategoryController =
      ItemCategoryController(itemCategory: 'Makanan');

  bool _validate = false;
  final AddItemController _addItemController = Get.find();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference itemCollection = firestore.collection('items');

    // CollectionReference historyCollection = firestore.collection('history');

    bool pop = true;

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        return pop;
      },
      child: Scaffold(
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
                Obx(() {
                  if (_addItemController.imagePick.value != null) {
                    return Container(
                      width: 150,
                      height: 150,
                      child: Image.file(
                        _addItemController.imagePick.value!,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return Container(
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
                          _showPicker(context);
                        },
                      ),
                    );
                  }
                }),
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
                DropDownCategoryWidget(
                  controller: itemCategoryController,
                  screenType: 2,
                  onSelected: () {
                    setState(() {});
                  },
                ),
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
                                'Simpan',
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.save,
                              )
                            ]),
                        onPressed: () async {
                          pop = false;
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
                            if (_addItemController.imagePick.value != null) {
                              await _addItemController.addItem(
                                itemNameController.text,
                                int.parse(itemCountController.text),
                                int.parse(itemPriceController.text),
                                itemCategoryController.itemCategory,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: 'Upload foto barang terlebih dahulu.',
                              );
                            }

                            Fluttertoast.showToast(
                              msg: 'Berhasil menambahkan barang',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              fontSize: 16.0,
                            );
                            _addItemController.imagePick.value = null;
                            itemNameController.clear();
                            itemCountController.clear();
                            itemPriceController.clear();

                            pop = true;
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
        screenType: 2,
        onSelected: () {
          setState(() {});
        },
      );

  void _showPicker(context) {
    var i = 0;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        i = 1;
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      i = 2;
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text('Hapus'),
                    onTap: () {
                      i = 3;
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }).then((value) async {
      if (i == 1) {
        if (!await _addItemController.imgFromGallery(context)) {
          Fluttertoast.showToast(
              msg: "Gagal, user masih belum mengizinkan",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
      if (i == 2) {
        if (!await _addItemController.imgFromCamera(context)) {
          Fluttertoast.showToast(
              msg: "Gagal, user masih belum mengizinkan",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
      i = 0;
    });
  }
}

import 'dart:io';
import 'package:basic_utils/basic_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  ItemCategoryController itemCategoryController =
      ItemCategoryController(itemCategory: 'Makanan');

  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference itemCollection = firestore.collection('items');

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Add New Item"),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Container(
                    color: Colors.grey,
                    padding: EdgeInsets.all(48),
                    child: IconButton(
                      iconSize: 36,
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
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                    child: TextField(
                  controller: itemNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Nama Item"),
                )),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  controller: itemCountController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: "Jumlah Item"),
                )),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                    child: DropDownCategoryWidget(
                  itemCategoryController,
                )),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 8,
                ),
                Flexible(
                    child: TextField(
                  keyboardType: TextInputType.number,
                  controller: itemPriceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixText: "Rp. ",
                      labelText: "Harga Per Item"),
                )),
                SizedBox(
                  height: 32,
                ),
                Flexible(
                    child: Container(
                  height: 50,
                  width: itemWidth / 3,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
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
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.save,
                            color: Colors.black,
                          )
                        ]),
                    onPressed: () {
                      if (itemNameController.text.isEmpty ||
                          itemCountController.text.isEmpty ||
                          itemPriceController.text.isEmpty) {
                        setState(() {
                          _validate = true;
                        });
                      } else {
                        itemCollection.add({
                          'namaBarang':
                              StringUtils.capitalize(itemNameController.text),
                          'jumlahBarang':
                              int.tryParse(itemCountController.text),
                          'hargaBarang': int.tryParse(itemPriceController.text),
                          'kategori': itemCategoryController.itemCategory,
                        });

                        itemNameController.text = '';
                        itemCountController.text = '';
                        itemPriceController.text = '';
                        Fluttertoast.showToast(
                            msg: 'Berhasil menambahkan barang baru',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   _validate = false;
                        //   return DashBoardScreen();
                        // }));
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
    itemNameController.dispose();
    itemCountController.dispose();
    itemPriceController.dispose();
    super.dispose();
  }

  Widget dropDown() => DropDownCategoryWidget(itemCategoryController);
}

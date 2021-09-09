import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/screens/main/widget/dropdown_category.dart';

class EditItemScreen extends StatefulWidget {
  final String img;
  final String productName;
  final String productCategory;
  final int productPrice;
  final int productStock;

  EditItemScreen(this.productName, this.productCategory, this.productPrice,
      this.productStock, this.img);

  @override
  _EditItemScreen createState() => _EditItemScreen();
}

class _EditItemScreen extends State<EditItemScreen> {
  late File _image;
  final itemNameController = TextEditingController();
  final itemCountController = TextEditingController();
  final itemPriceController = TextEditingController();
  var itemCategoryController = ItemCategoryController(itemCategory: '');
  final User? user = FirebaseServices.user;

  bool _validate = false;

  final ItemsController _itemsController = Get.find();

  @override
  void initState() {
    super.initState();
    _itemsController.photoUrl.value = widget.img;
    itemNameController.text = widget.productName;
    itemPriceController.text = widget.productPrice.toString();
    itemCountController.text = widget.productStock.toString();
    itemCategoryController =
        ItemCategoryController(itemCategory: widget.productCategory);
  }

  @override
  Widget build(BuildContext context) {
    //set initial value

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
      ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
              MaterialButton(
                onPressed: () {
                  _showPicker(context);
                },
                child: Container(
                  height: 150,
                  width: 150,
                  child: Obx(
                    () => Image.network(
                      _itemsController.photoUrl.value,
                      fit: BoxFit.cover,
                    ),
                  ),
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
              DropDownCategoryWidget(
                controller: itemCategoryController,
                screenType: 2,
                onSelected: () {},
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
                              width: 10,
                            ),
                            Icon(
                              Icons.save,
                              color: Colors.black,
                            )
                          ]),
                      onPressed: () {
                        if (itemNameController.text.isEmpty ||
                            itemCountController.text.isEmpty ||
                            itemPriceController.text.isEmpty ||
                            itemCategoryController.itemCategory == '') {
                          Fluttertoast.showToast(
                            msg:
                                'Gagal mengupdate barang. Seluruh kolom harus diisi.',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0,
                          );
                          setState(() {
                            _validate = true;
                          });
                        } else {
                          _updateItem(
                              widget.productName,
                              itemNameController.text,
                              int.tryParse(itemCountController.text)!.toInt(),
                              int.tryParse(itemPriceController.text)!.toInt(),
                              itemCategoryController.itemCategory);
                          FirebaseServices.addHistory(itemNameController.text,
                              user!.displayName.toString(), 2);

                          Fluttertoast.showToast(
                            msg: 'Berhasil mengupdate barang',
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            fontSize: 16.0,
                          );
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

  Future<void> _updateItem(String productName, String newName, int newCount,
      int newPrice, String newCategory) async {
    CollectionReference itemCollection =
        FirebaseFirestore.instance.collection('items');

    var filteredDocumentByName =
        await itemCollection.where('namaBarang', isEqualTo: productName).get();
    int oldCount = filteredDocumentByName.docs.first['jumlahBarang'];
    for (var doc in filteredDocumentByName.docs) {
      await doc.reference
          .update({'namaBarang': StringUtils.capitalize(newName)});
      await doc.reference.update({'jumlahBarang': newCount});
      await doc.reference.update({'hargaBarang': newPrice});
      await doc.reference.update({'kategori': newCategory});
    }
    if (oldCount > newCount) {
      await FirebaseServices.updateTotalStock(
          oldCount - newCount, 1, _itemsController.getTotalStock);
    } else {
      await FirebaseServices.updateTotalStock(
          newCount - oldCount, 0, _itemsController.getTotalStock);
    }
  }

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
                ],
              ),
            ),
          );
        }).then((value) async {
      if (i == 1) {
        if (!await _itemsController.imgFromGallery(
            context, widget.productName, widget.productCategory)) {
          Fluttertoast.showToast(
            msg: 'Gagal, belum ada izin',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      }
      if (i == 2) {
        if (!await _itemsController.imgFromCamera(
            context, widget.productName, widget.productCategory)) {
          Fluttertoast.showToast(
            msg: 'Gagal, belum ada izin',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            fontSize: 16.0,
          );
        }
      }
      i = 0;
    });
  }

  @override
  void dispose() {
    itemNameController.dispose();
    itemCountController.dispose();
    itemPriceController.dispose();
    super.dispose();
  }
}

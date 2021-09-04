import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/util/request_permission.dart';

class AddItemController extends GetxController {
  var photoUrl = "".obs;
  var imagePicker = ImagePicker();
  Rx<File?> imagePick = Rx<File?>(null);

  Future<void> addItem(String namaBarang, int jumlahBarang, int hargaBarang,
      String kategori) async {
    ItemsController _item = Get.find();
    Fluttertoast.showToast(msg: "Menambah Barang...", timeInSecForIosWeb: 3600);
    await uploadImage(namaBarang, kategori);
    await FirebaseServices.addItem(
        namaBarang, jumlahBarang, hargaBarang, kategori, photoUrl.value);
    await FirebaseServices.addHistory(
        namaBarang, FirebaseServices.user.displayName!, 1);
    await FirebaseServices.updateTotalStock(
        jumlahBarang, 0, _item.getTotalStock);

    Fluttertoast.cancel();
  }

  Future<bool> imgFromCamera(BuildContext context) async {
    if (await requestPermission(Permission.camera)) {
      XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
      if (image != null) {
        imagePick.value = File(image.path);
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<bool> imgFromGallery(BuildContext context) async {
    if (await requestPermission(Permission.accessMediaLocation)) {
      XFile? image = await imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: 50);
      if (image != null) {
        imagePick.value = File(image.path);

        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  uploadImage(String namaBarang, String kategori) async {
    try {
      var firebaseStorage = FirebaseStorage.instance;
      await firebaseStorage
          .ref('uploads/$namaBarang-$kategori.png')
          .putFile(imagePick.value!);

      var url = await firebaseStorage
          .ref('uploads/$namaBarang-$kategori.png')
          .getDownloadURL();
      photoUrl.value = url;
    } catch (e) {
      print(e);
    }
  }
}

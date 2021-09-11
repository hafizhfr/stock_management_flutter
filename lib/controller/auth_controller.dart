import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stock_management_flutter/common/dialog.dart';

import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/routes/app_routes.dart';
import 'package:stock_management_flutter/util/request_permission.dart';

class AuthController extends GetxController {
  Stream<User?> get userState => FirebaseServices.firebaseUserStream;

  User get user => FirebaseServices.user;
  static var imagePicker = ImagePicker();
  static late Rx<File> imagePick;
  static final auth = FirebaseAuth.instance;
  static var photoUrl = "".obs;
  late StreamSubscription userStream;
  final userName = "".obs;

  Future<void> signOut() async {
    FirebaseServices.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseServices.signIn(email, password);
      Get.offAllNamed(Routes.MAIN);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'Akun tidak ditemukan.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Password salah.');
      }
      return null;
    }
  }

  Future<void> signUp(String fullName, String email, String password) async {
    try {
      await FirebaseServices.signUp(fullName, email, password);
      Fluttertoast.showToast(msg: 'Berhasil membuat akun baru.');
      userName.value = fullName;
      Get.offAllNamed(Routes.MAIN);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Alamat email sudah digunakan akun lain.');
      } else {
        Fluttertoast.showToast(msg: e.message!);
      }
      Get.back();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String fullName, String email) async {
    try {
      await FirebaseServices.updateName(fullName);
      await FirebaseServices.updateEmail(email);
      Fluttertoast.showToast(msg: 'Profile berhasil diupdate');
      userName.value = fullName;
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    userStream = userState.listen((event) {
      if (event == null) {
        photoUrl.value = "";
        userName.value = "";
      } else {
        if (event.photoURL != null) {
          photoUrl.value = event.photoURL!;
        }
        if (event.displayName != null) {
          userName.value = event.displayName!;
        }
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    userStream.cancel();
    super.onClose();
  }

  Future<bool> imgFromCamera(BuildContext context) async {
    if (await requestPermission(Permission.camera)) {
      XFile? image = await imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
      if (image != null) {
        imagePick = File(image.path).obs;
        loaderDialog(context, CircularProgressIndicator(), "Upload Image");
        await uploadImage();
        Get.back();
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
        imagePick = File(image.path).obs;
        loaderDialog(context, CircularProgressIndicator(), "Upload Image");
        await uploadImage();
        Navigator.pop(Get.overlayContext!);
        return true;
      }
      return true;
    } else {
      return false;
    }
  }

  Future<void> uploadImage() async {
    try {
      var firebaseStorage = FirebaseStorage.instance;
      await firebaseStorage
          .ref('uploads/${user.uid}.png')
          .putFile(imagePick.value);

      var url =
          await firebaseStorage.ref('uploads/${user.uid}.png').getDownloadURL();
      await user.updatePhotoURL(url);
      photoUrl.value = url;
    } catch (e) {
      print(e);
    }
  }
}

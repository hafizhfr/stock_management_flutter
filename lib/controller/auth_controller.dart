import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:stock_management_flutter/data/provider/firebase_services.dart';
import 'package:stock_management_flutter/routes/app_routes.dart';

class AuthController extends GetxController {
  Stream<User?> get userState => FirebaseServices.firebaseUserStream;

  User get user => FirebaseServices.user;

  Future<void> signOut() => FirebaseServices.signOut();
  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseServices.signIn(email, password);
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'Alamat email sudah digunakan akun lain.');
      } else {
        Fluttertoast.showToast(msg: e.message!);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String fullName, String email) async {
    try {
      await FirebaseServices.updateName(fullName);
      await FirebaseServices.updateEmail(email);
      Fluttertoast.showToast(msg: 'Profile berhasil diupdate');
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onInit() {
    userState.listen((event) {
      if (event == null) {
        Get.offAllNamed(Routes.LOGIN);
      } else {
        Get.offAllNamed(Routes.MAIN);
      }
    });
    super.onInit();
  }
}

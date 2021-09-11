import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:stock_management_flutter/data/models/item_model.dart';

class FirebaseServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference itemCollection = firestore.collection('items');
  static CollectionReference historyCollection =
      firestore.collection('history');
  static DocumentReference stockDocument =
      firestore.collection('itemsTotal').doc('dashboardStatus');

// USER
  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();

  static User get user => _auth.currentUser!;

  static Future<void> signOut() async => _auth.signOut();

  static Future<void> signUp(
      String fullName, String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
    User? user = result.user;
    user!.updateDisplayName(fullName);
  }

  static User getUser() {
    return _auth.currentUser!;
  }

  static Future<User?> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = userCredential.user;
    return user;
  }

  static Future<void> updateName(String newName) async {
    await _auth.currentUser!.updateDisplayName(newName);
  }

  static Future<void> updateEmail(String newEmail) async {
    await _auth.currentUser!.updateEmail(newEmail);
  }

  //ITEM

  static Future<List<Item>> getItemListOnce() async {
    try {
      var itemDocs = await itemCollection.get();
      if (itemDocs.docs.isNotEmpty) {
        return itemDocs.docs
            .map((e) => Item.fromMap(e.data() as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Future<void> addItem(String namaBarang, int jumlahBarang,
      int hargaBarang, String kategori, String img) async {
    await itemCollection.doc(("$namaBarang-$kategori").toLowerCase()).set({
      'namaBarang': StringUtils.capitalize(namaBarang),
      'jumlahBarang': jumlahBarang,
      'hargaBarang': hargaBarang,
      'kategori': kategori,
      'img': img
    });
  }

  static Future<void> updateItemImg(
      String namaBarang, String kategori, String img) async {
    await itemCollection
        .doc(("$namaBarang-$kategori").toLowerCase())
        .update({'img': img});
  }

  static Future<void> updateStock(
      String namaBarang, String kategori, int newStock) async {
    await itemCollection.doc(("$namaBarang-$kategori").toLowerCase()).set({
      'namaBarang': StringUtils.capitalize(namaBarang),
      'jumlahBarang': newStock,
      'kategori': kategori,
    }, SetOptions(merge: true));
  }

  static Future<void> deleteItems(String name) async {
    var item = await itemCollection.where('namaBarang', isEqualTo: name).get();
    await itemCollection.doc(item.docs.first.id).delete();
  }

  static Future<void> addHistory(
      String itemName, String userFullName, int actionType) async {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateFormat timeFormat = DateFormat('HH:mm:ss');

    String currentDate = dateFormat.format(DateTime.now());
    String currentTime = timeFormat.format(DateTime.now());
    String userAction = "";
    if (actionType == 1) {
      userAction = 'menambahkan';
    } else if (actionType == 2) {
      userAction = 'mengubah';
    } else if (actionType == 3) {
      userAction = 'menghapus';
    }

    historyCollection.add({
      'pesan': '$userFullName $userAction $itemName',
      'tanggal': '$currentDate',
      'waktu': '$currentTime',
      'created': '${DateTime.now()}'
    });
  }

  static Future<void> updateTotalStock(
      int increment, int screenType, int current) async {
    int newTotal = current;
    if (screenType == 0) {
      newTotal += increment;
    } else if (screenType == 1) {
      newTotal -= increment;
    }
    stockDocument.update({'stockIn': newTotal});
  }

  static Future<void> updateTotalSales(int increment, int current) async {
    stockDocument.update({'totalSales': current + increment});
  }

  static Future<void> updateStockOut(int sales, int current) async {
    int newTotal = current;
    newTotal += sales;

    stockDocument.update({'stockOut': newTotal});
    //todo: add stock out
  }

  static Stream<int> getStockOutStream() {
    return stockDocument.snapshots().map((event) => event.get('stockOut'));
  }

  static Stream<int> getTotalSalesStream() {
    return stockDocument.snapshots().map((event) => event.get('totalSales'));
  }

  static Stream<int> getStockInStream() {
    return stockDocument.snapshots().map((event) => event.get('stockIn'));
  }

  static Stream<QuerySnapshot> getHistoryStream() {
    return historyCollection.orderBy("created", descending: true).snapshots();
  }
}

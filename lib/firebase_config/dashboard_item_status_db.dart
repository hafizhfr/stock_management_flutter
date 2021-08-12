import 'package:cloud_firestore/cloud_firestore.dart';

class ItemStatus {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference collection = firestore.collection('itemsTotal');
  static int _totalStock;

//screenType; 0 = add, 1 = delete
  static void updateTotalStock(int num, int screenType) {
    int newTotal = getCurrentStock();
    if (screenType == 0) {
      newTotal += num;
    } else if (screenType == 1) {
      newTotal -= num;
    }

    collection.doc('dashboardStatus').update({'stockIn': newTotal});
  }

  static int getCurrentStock() {
    collection.doc('dashboardStatus').snapshots().listen((event) {
      _totalStock = event.get('stockIn');
    });
    return _totalStock;
  }
}

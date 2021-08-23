import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ItemStatus {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static DocumentReference document =
      firestore.collection('itemsTotal').doc('dashboardStatus');
  static int _totalStock;
  static int _stockOut;
  static int _totalSales;

//screenType; 0 = add, 1 = delete
  static Future<void> updateTotalStock(int increment, int screenType) async {
    int newTotal = getCurrentStock();
    print(increment);

    print(_totalStock);
    if (screenType == 0) {
      newTotal += increment;
    } else if (screenType == 1) {
      newTotal -= increment;
    }
    print(newTotal);
    document.update({'stockIn': newTotal});
    //todo: add stock out
  }

  static int getCurrentStock() {
    document.snapshots().listen((event) async {
      _totalStock = await event.get('stockIn');
    });

    if (_totalStock != null) {
      return _totalStock;
    }
    return 0;
  }

  static int getStockOut() {
    document.snapshots().listen((event) async {
      _stockOut = await event.get('stockOut');
    });

    if (_stockOut != null) {
      return _stockOut;
    }
    return 0;
  }

  static int getTotalSales() {
    document.snapshots().listen((event) async {
      _totalSales = await event.get('totalSales');
    });

    if (_totalSales != null) {
      return _totalSales;
    }
    return 0;
  }
}

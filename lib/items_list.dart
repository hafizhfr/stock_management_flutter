import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management_flutter/item.dart';

class ItemList {
  static final CollectionReference itemCollection =
      FirebaseFirestore.instance.collection('items');

  static List<Item> _getItemList(QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return Item(
          namaBarang: doc.get('namaBarang') ?? '',
          hargaBarang: doc.get('hargaBarang') ?? '',
          jumlahBarang: doc.get('jumlahBarang') ?? '',
          kategori: doc.get('kategori') ?? '',
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  static Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_getItemList);
  }
}

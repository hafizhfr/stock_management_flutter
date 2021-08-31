import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stock_management_flutter/item.dart';

class ItemList {
  static final CollectionReference _itemCollection =
      FirebaseFirestore.instance.collection('items');

  // List<Item> _items;

  static Future getItemListOnce() async {
    try {
      var itemDocs = await _itemCollection.get();
      if (itemDocs.docs.isNotEmpty) {
        return itemDocs.docs.map((e) => Item.fromMap(e.data())).toList();
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  // Future fetchItems() async {
  //   var itemsResult = await _getItemListOnce();
  //   if (itemsResult is List<Item>) {
  //     _items = itemsResult;
  //     print(_items);
  //   }
  // }

  // static Stream<List<Item>> get items {
  //   return itemCollection.snapshots().map(_getItemList);
  // }
}

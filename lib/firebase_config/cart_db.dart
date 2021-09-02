import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference itemCollection = firestore.collection('items');
  static CollectionReference cartCollection = firestore.collection('cart');
  int _cartTotal;

  static void addToDB(String itemName, int itemCount, int itemPrice) {
    cartCollection.add(
      {
        'itemName': itemName,
        'itemCount': itemCount,
        'itemPrice': itemPrice * itemCount
      },
    );
  }

  // CollectionReference get collection => cartCollection;
}

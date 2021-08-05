import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/card_product_widget.dart';

class ItemListWidget extends StatefulWidget {
  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  List<String> itemList = [];
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference itemCollection = firestore.collection('items');

    return Container(
      // child: Scrollbar(
      child: ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: itemCollection.snapshots(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data.docs.map((document) {
                      return ProductCardWidget('ya', document['namaBarang'],
                          document['hargaBarang'], document['jumlahBarang']);
                    }).toList(),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ],
      ),
      // ),
    );
  }
}

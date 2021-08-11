import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/card_product_widget.dart';

class ItemListWidget extends StatefulWidget {
  final String searchQuery;
  final bool isLowStockPage;
  ItemListWidget(this.searchQuery, this.isLowStockPage);
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
      // height: MediaQuery.of(context).size.height,
      // child: Scrollbar(
      child: ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: !widget.isLowStockPage
                ? widget.searchQuery == ''
                    ? itemCollection.orderBy('namaBarang').snapshots()
                    : itemCollection
                        .where('namaBarang',
                            isGreaterThanOrEqualTo: widget.searchQuery)
                        .orderBy('namaBarang')
                        .snapshots()
                : widget.searchQuery == ''
                    ? itemCollection
                        .where('jumlahBarang', isLessThanOrEqualTo: 5)
                        .snapshots()
                    : itemCollection
                        .where('jumlahBarang', isLessThanOrEqualTo: 5)
                        // .where('namaBarang',
                        //     isGreaterThanOrEqualTo: widget.searchQuery)
                        .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: snapshot.data.docs.map((document) {
                    return ProductCardWidget(
                        'imgTemp',
                        document['namaBarang'],
                        document['kategori'],
                        document['hargaBarang'],
                        document['jumlahBarang']);
                  }).toList(),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
      // ),
    );
  }
}

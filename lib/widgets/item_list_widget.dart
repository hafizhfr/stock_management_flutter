import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/card_product_widget.dart';

class ItemListWidget extends StatefulWidget {
  final String searchQuery;
  final String searchByCategoryQuery;
  final bool isLowStockPage;
  ItemListWidget(
      this.searchQuery, this.searchByCategoryQuery, this.isLowStockPage);
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
            //TODO: NAMBAH FIELD BARU isLowStock dan CLASS BARU BUAT NGECEK TIAP ADD, EDIT
            //.where('jumlahBarang', isLessThanOrEqualTo: 5)
            stream: !widget.isLowStockPage
                ? widget.searchQuery == ''
                    ? widget.searchByCategoryQuery == ''
                        ? itemCollection.orderBy('namaBarang').snapshots()
                        : itemCollection
                            .where('kategori',
                                isEqualTo: widget.searchByCategoryQuery)
                            .orderBy('namaBarang')
                            .snapshots()
                    : widget.searchByCategoryQuery == ''
                        ? itemCollection
                            .where('namaBarang',
                                isGreaterThanOrEqualTo: widget.searchQuery)
                            .orderBy('namaBarang')
                            .snapshots()
                        : itemCollection
                            .where('namaBarang',
                                isGreaterThanOrEqualTo: widget.searchQuery)
                            .where('kategori',
                                isEqualTo: widget.searchByCategoryQuery)
                            .orderBy('namaBarang')
                            .snapshots()
                : widget.searchQuery == ''
                    ? widget.searchByCategoryQuery == ''
                        ? itemCollection
                            .where('jumlahBarang', isLessThanOrEqualTo: 5)
                            .snapshots()
                        : itemCollection
                            .where('kategori',
                                isEqualTo: widget.searchByCategoryQuery)
                            .where('jumlahBarang', isLessThanOrEqualTo: 5)
                            .snapshots()
                    : widget.searchByCategoryQuery == ''
                        ? itemCollection
                            .where('jumlahBarang', isLessThanOrEqualTo: 5)
                            // .where('namaBarang',
                            //     isGreaterThanOrEqualTo: widget.searchQuery)
                            .snapshots()
                        : itemCollection
                            .where('jumlahBarang', isLessThanOrEqualTo: 5)
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
              }

              return CircularProgressIndicator();
            },
          ),
        ],
      ),
      // ),
    );
  }
}

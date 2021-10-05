import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/screens/main/widget/card_product.dart';

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
  final ItemsController _itemsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _itemsController.getItemStreamByQuery(
                widget.searchQuery, widget.searchByCategoryQuery),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                if (widget.isLowStockPage) {
                  return Column(
                    children: snapshot.data!.docs.map((document) {
                      if (document['jumlahBarang'] <= 5) {
                        return ProductCardWidget(
                          document['img'],
                          document['namaBarang'],
                          document['kategori'],
                          document['hargaBarang'],
                          document['jumlahBarang'],
                        );
                      }
                      return Container();
                    }).toList(),
                  );
                } else {
                  return Column(
                    children: snapshot.data!.docs.map((document) {
                      return ProductCardWidget(
                        document['img'],
                        document['namaBarang'],
                        document['kategori'],
                        document['hargaBarang'],
                        document['jumlahBarang'],
                      );
                    }).toList(),
                  );
                }
              }

              return Center(
                child: SizedBox(
                  width: 50.0,
                  height: 50.0,
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

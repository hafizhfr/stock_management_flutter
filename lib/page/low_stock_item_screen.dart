import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/dropdown_category_widget.dart';
import 'package:stock_management_flutter/widgets/item_list_widget.dart';

import 'add_item_screen.dart';

class LowStockItemScreen extends StatefulWidget {
  @override
  _LowStockItemScreen createState() => _LowStockItemScreen();
}

class _LowStockItemScreen extends State<LowStockItemScreen> {
  final searchController = TextEditingController();
  String searchQuery = '';

  ItemCategoryController controller = ItemCategoryController(itemCategory: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Item'),
        backgroundColor: Colors.amber,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddItemScreen();
          }));
        },
      ),
      body: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                                print(searchQuery);
                              });
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                                icon: Icon(
                              Icons.search,
                              color: Colors.black,
                            )))),
                    Expanded(child: dropDown()),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                // color: Colors.black,
                // height: MediaQuery.of(context).size.height,
                child: ItemListWidget(searchQuery, false),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dropDown() => DropDownCategoryWidget(controller, 1);
  // Widget productCard() => ProductCardWidget();
}

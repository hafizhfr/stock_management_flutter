import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/dropdown_category_widget.dart';
import 'package:stock_management_flutter/widgets/item_list_widget.dart';

import 'add_item_screen.dart';

class AllItemScreen extends StatefulWidget {
  @override
  _AllItemScreen createState() => _AllItemScreen();
}

class _AllItemScreen extends State<AllItemScreen> {
  final searchController = TextEditingController();
  ItemCategoryController controller = ItemCategoryController(itemCategory: '');

  String searchQuery;
  String searchByCategoryQuery;
  @override
  void initState() {
    super.initState();
    searchQuery = '';
    searchByCategoryQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Item'),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toUpperCase();
                                print(searchQuery);
                              });
                            },
                            controller: searchController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              prefixIcon: Icon(Icons.search
                                  //   icon: Icon(
                                  // Icons.search,
                                  // color: Colors.black,
                                  ),
                              hintText: "Search...",
                            ))),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropDownCategoryWidget(
                        controller: controller,
                        screenType: 1,
                        onSelected: () {
                          setState(() {
                            searchByCategoryQuery = controller.itemCategory;
                            print(searchByCategoryQuery);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                // color: Colors.black,
                // height: MediaQuery.of(context).size.height,
                child:
                    ItemListWidget(searchQuery, searchByCategoryQuery, false),
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

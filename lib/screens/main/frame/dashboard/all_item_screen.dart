import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/routes/app_routes.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/add_item/add_item_screen.dart';
import 'package:stock_management_flutter/screens/main/widget/dropdown_category.dart';
import 'package:stock_management_flutter/screens/main/widget/item_list_widget.dart';

class AllItemScreen extends StatefulWidget {
  @override
  _AllItemScreen createState() => _AllItemScreen();
}

class _AllItemScreen extends State<AllItemScreen> {
  final searchController = TextEditingController();
  ItemCategoryController controller = ItemCategoryController(itemCategory: '');

  late String searchQuery;
  late String searchByCategoryQuery;
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
        title: Text('All Items'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          Get.toNamed(Routes.ADDITEMS);
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
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          prefixIcon: Icon(
                            Icons.search
                            //   icon: Icon(
                            // Icons.search,
                            // color: Colors.black,
                            ,
                          ),
                          hintText: "Search...",
                        ),
                      ),
                    ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/firebase_config/auth_services.dart';
import 'package:stock_management_flutter/firebase_config/dashboard_item_status_db.dart';
import 'package:stock_management_flutter/page/add_cart_screen.dart';
import 'package:stock_management_flutter/page/add_item_screen.dart';
import 'package:stock_management_flutter/page/all_item_screen.dart';
import 'package:stock_management_flutter/page/login_screen.dart';
import 'package:stock_management_flutter/page/low_stock_item_screen.dart';
import 'package:stock_management_flutter/page/register_screen.dart';
import 'package:stock_management_flutter/widgets/card_product_widget.dart';
import 'package:stock_management_flutter/widgets/item_list_widget.dart';

class DashBoardScreen extends StatelessWidget {
  final User user;

  DashBoardScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
          elevation: 0,
          title: Text(
            'Welcome, ${user.displayName}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: DashboardScreenMobile(),
      ),
    );
  }
}

class DashboardScreenMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: itemHeight * 4.5 / 10,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(32))),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 32),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total Sales",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Rp.1.000.000",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle2,
                              )
                            ],
                          )),
                          Container(
                            width: 2,
                            height: 48,
                            color: Colors.amber,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Stock In",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ItemStatus.getCurrentStock().toString(),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline5,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 2,
                            height: 48,
                            color: Colors.amber,
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Stock Out",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "150",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline5,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 32, bottom: 16, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Quick Actions",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: quickActionCard(
                              context,
                              AddItemScreen(),
                              Colors.amberAccent,
                              "Add Item",
                              Icons.add_circle_outline_outlined),
                          flex: 1,
                        ),
                        Expanded(
                          child: quickActionCard(context, AddToCartScreen(),
                              Colors.blueAccent, "Sell", Icons.shopping_cart),
                          flex: 1,
                        ),
                        Expanded(
                          child: quickActionCard(context, LowStockItemScreen(),
                              Colors.redAccent, "Low Stock", Icons.warning),
                          flex: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Products",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AllItemScreen();
                              }));
                            },
                            child: Text(
                              "View All",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .apply(color: Colors.blue),
                              textAlign: TextAlign.right,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: ItemListWidget('', false),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget quickActionCard(BuildContext context, StatefulWidget widget,
      Color color, String label, IconData icon) {
    return Card(
        color: color,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    icon,
                    size: 64,
                    color: Colors.black,
                  ),
                  iconSize: 64,
                  alignment: Alignment.center,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return widget;
                    }));
                  }),
              Text(
                label,
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ));
  }
// Widget productCard() => ProductCardWidget();ddddddddddddd
}

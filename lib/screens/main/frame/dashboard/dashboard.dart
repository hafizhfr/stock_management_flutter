import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';
import 'package:stock_management_flutter/routes/app_routes.dart';
import 'package:stock_management_flutter/screens/main/widget/item_list_widget.dart';

class DashboardScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final ItemsController _itemsController = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber,
        elevation: 0,
        title: Obx(
          () => Text(
            'Welcome, ${_authController.userName}',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
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
                              Obx(
                                () => Text(
                                  'Rp ${_itemsController.getTotalSales}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
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
                                Obx(
                                  () => Text(
                                    _itemsController.getTotalStock.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
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
                                Obx(
                                  () => Text(
                                    _itemsController.getStockOut.toString(),
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
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
                      children: <Widget>[
                        Expanded(
                          child: quickActionCard(
                              context,
                              Routes.ADDITEMS,
                              Colors.amberAccent,
                              "Add Item",
                              Icons.add_circle_outline_outlined),
                          flex: 1,
                        ),
                        Expanded(
                          child: quickActionCard(context, Routes.ADDCART,
                              Colors.blueAccent, "Sell", Icons.shopping_cart),
                          flex: 1,
                        ),
                        Expanded(
                          child: quickActionCard(context, Routes.LOWSTOCK,
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
                              Get.toNamed(Routes.ALLITEMS);
                            },
                            child: Text(
                              "View All",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
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
                      child: ItemListWidget('', '', false),
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

  Widget quickActionCard(BuildContext context, String routes, Color color,
      String label, IconData icon) {
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
                  size: MediaQuery.of(context).size.width * 0.125,
                  color: Colors.black,
                ),
                iconSize: MediaQuery.of(context).size.width * 0.125,
                alignment: Alignment.center,
                onPressed: () {
                  Get.toNamed(routes);
                }),
            FittedBox(
              child: Text(
                label,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

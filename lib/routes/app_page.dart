import 'package:get/get.dart';
import 'package:stock_management_flutter/bindings/add_item_binding.dart';
import 'package:stock_management_flutter/bindings/items_binding.dart';
import 'package:stock_management_flutter/routes/app_routes.dart';
import 'package:stock_management_flutter/screens/auth/login_page.dart';
import 'package:stock_management_flutter/screens/auth/register_screen.dart';
import 'package:stock_management_flutter/screens/initial_page.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/add_item/add_item_screen.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/all_item_screen.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/low_stock/low_stock_item_screen.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/sell/add_cart_screen.dart';
import 'package:stock_management_flutter/screens/main/main_page.dart';
import 'package:stock_management_flutter/screens/main/widget/item_list_widget.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => InitialPage()),
    GetPage(name: Routes.LOGIN, page: () => LoginPage()),
    GetPage(name: Routes.REGISTER, page: () => RegisterPage()),
    GetPage(name: Routes.MAIN, page: () => MainPage(), binding: ItemsBinding()),
    GetPage(
        name: Routes.ADDITEMS,
        page: () => AddItemScreen(),
        binding: AddItemBinding()),
    GetPage(name: Routes.ADDCART, page: () => AddToCartScreen()),
    GetPage(name: Routes.LOWSTOCK, page: () => LowStockItemScreen()),
    GetPage(name: Routes.ALLITEMS, page: () => AllItemScreen()),
  ];
}

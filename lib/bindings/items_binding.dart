import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/items_controller.dart';

class ItemsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ItemsController());
  }
}

import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/add_item_controller.dart';

class AddItemBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddItemController());
  }
}

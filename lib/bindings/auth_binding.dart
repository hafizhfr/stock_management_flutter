import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

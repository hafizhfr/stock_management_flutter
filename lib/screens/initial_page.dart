import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/controller/auth_controller.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, navigatePage);
  }

  void navigatePage() async {
    if (AuthController.auth.currentUser == null) {
      Get.offNamed('/login');
    } else {
      Get.offNamed('/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

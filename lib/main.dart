import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/bindings/auth_binding.dart';
import 'package:stock_management_flutter/common/styles.dart';
import 'package:stock_management_flutter/routes/app_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Stock Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primary,
        accentColor: secondary,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: primary),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: primary,
                textStyle: TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0))))),
        buttonTheme: ButtonThemeData(
          buttonColor: primary,
          textTheme: ButtonTextTheme.primary,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        textTheme: myTextTheme.apply(
            bodyColor: Colors.black, displayColor: Colors.black),
      ),
      getPages: AppPages.pages,
      initialBinding: AuthBinding(),
    );
  }
}

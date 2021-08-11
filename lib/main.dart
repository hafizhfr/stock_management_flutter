import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stock_management_flutter/firebase_config/auth_services.dart';
import 'package:stock_management_flutter/page/dashboard_screen.dart';
import 'package:stock_management_flutter/page/history_screen.dart';
import 'package:stock_management_flutter/page/login_screen.dart';
import 'package:stock_management_flutter/page/profile_screen.dart';
import 'package:stock_management_flutter/page/register_screen.dart';
import 'package:stock_management_flutter/widgets/styles.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Management',
      theme: ThemeData(

        primaryColor: primary,
        accentColor: secondary,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: secondary,
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
      home: MyHomePage(title: 'Stock Management Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final User user = AuthServices.getUser();
    final screens = [
      DashBoardScreen(user),
      HistoryScreen(),
      ProfileScreen(user)
    ];

    if (user == null) {
      Fluttertoast.showToast(msg: 'Anda harus login terlebih dahulu.');
      return LoginScreen();
    } else {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          fixedColor: Colors.amber,
          currentIndex: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 36,
          items: [
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.home,
                  color: Colors.amber,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.history,
                  color: Colors.amber,
                ),
                label: "History"),
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.account_circle_rounded,
                  color: Colors.amber,
                ),
                label: "Profile")
          ],
          onTap: onTabTapped,
        ),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
      );
    }
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

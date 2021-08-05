import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/page/dashboard_screen.dart';
import 'package:stock_management_flutter/page/history.dart';
import 'package:stock_management_flutter/page/login_screen.dart';
import 'package:stock_management_flutter/page/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  final screens = [DashBoardScreen(), HistoryScreen(), RegisterScreen()];

  @override
  Widget build(BuildContext context) {
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

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

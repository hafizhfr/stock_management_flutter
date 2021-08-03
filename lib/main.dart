import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/dashboard_screen.dart';
import 'package:stock_management_flutter/widgets/history.dart';
import 'package:stock_management_flutter/widgets/login_screen.dart';
import 'package:stock_management_flutter/widgets/register_screen.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final screens = [DashBoardScreen(), HistoryScreen(), LoginScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        fixedColor: Colors.amber,
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.home,
                size: 36,
                color: Colors.amber,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.history,
                size: 36,
                color: Colors.amber,
              ),
              label: "History"),
          BottomNavigationBarItem(
              icon: new Icon(
                Icons.account_circle_rounded,
                size: 36,
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

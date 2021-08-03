import 'package:flutter/material.dart';
import 'package:stock_management_flutter/widgets/dashboard_screen.dart';
import 'package:stock_management_flutter/widgets/history.dart';
import 'package:stock_management_flutter/widgets/login_screen.dart';
import 'package:stock_management_flutter/widgets/register_screen.dart';

void main() {
  runApp(MyApp());
}
//TEST
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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [
    DashBoardScreen(),
    HistoryScreen(),
    LoginScreen()
  ];
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
  void onTabTapped(int index){
    setState(() {
      currentIndex = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/dashboard.dart';
import 'package:stock_management_flutter/screens/main/frame/history_screen.dart';
import 'package:stock_management_flutter/screens/main/frame/profile_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> screens = [
    DashboardScreen(),
    HistoryScreen(),
    ProfileScreen(),
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
        children: screens,
        index: currentIndex,
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_management_flutter/screens/main/frame/dashboard/dashboard.dart';
import 'package:stock_management_flutter/screens/main/frame/history.dart';
import 'package:stock_management_flutter/screens/main/frame/profil.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final currentIndex = 0.obs;

  final List<Widget> screens = [Dashboard(), History(), Profil()];

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
      body: Obx(
        () => screens[currentIndex.value],
      ),
    );
  }

  void onTabTapped(int index) {
    currentIndex.value = index;
  }
}

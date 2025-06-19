import 'package:flutter/material.dart';
import 'package:foodie/shared/bottomnavigationbar.dart';
import 'package:foodie/views/interface/cartpage.dart';
import 'package:foodie/views/interface/homepage.dart';
import 'package:foodie/views/interface/managepage.dart';

class FoodieMainPage extends StatefulWidget {
  const FoodieMainPage({Key? key}) : super(key: key);

  @override
  State<FoodieMainPage> createState() => _FoodieMainPageState();
}

class _FoodieMainPageState extends State<FoodieMainPage> {
  int _selectedIndex = 1;

  final List<Widget> _screens = const [
    ManageMenuPage(),

    HomePage(),

    CartPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: FoodieBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

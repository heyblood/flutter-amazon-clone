import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    Center(
      child: Text('acoount screen'),
    ),
    Center(
      child: Text('cart screen'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalVarialbles.selectedNavBarColor,
        unselectedItemColor: GlobalVarialbles.unselectedNavBarColor,
        backgroundColor: GlobalVarialbles.backgroundColor,
        iconSize: 28,
        onTap: _onItemTap,
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Account',
          ),
          // CART
          BottomNavigationBarItem(
            icon: Badge(
                // elevation: 0,
                badgeContent: Text('20', style: TextStyle(fontSize: 10)),
                // badgeColor: Colors.white,
                child: Icon(Icons.shopping_cart_outlined)),
            // icon: Container(),
            label: 'Cart',
          ),
        ],
      ),
    );
  }

  void _onItemTap(int index) => setState(() {
        _selectedIndex = index;
      });
}

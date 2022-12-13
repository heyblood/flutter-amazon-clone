import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/admin/products/screens/products_screen.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  static const String routeName = '/admin';

  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;

  List<Widget> pages = const [
    ProductsScreen(),
    Center(
      child: Text('Analytics page'),
    ),
    Center(
      child: Text('Cart page'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVarialbles.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: GlobalVarialbles.selectedNavBarColor,
        unselectedItemColor: GlobalVarialbles.unselectedNavBarColor,
        backgroundColor: GlobalVarialbles.backgroundColor,
        iconSize: 28,
        onTap: _onItemTap,
        items: const [
          // Posts
          BottomNavigationBarItem(
            icon: Icon(Icons.list_outlined),
            label: 'Posts',
          ),
          // Analytics
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analytics',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }

  void _onItemTap(int index) => setState(() {
        _selectedIndex = index;
      });
}

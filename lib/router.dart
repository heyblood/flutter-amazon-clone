import 'package:amazon_clone/admin/admin_page.dart';
import 'package:amazon_clone/admin/products/screens/add_prodcut_screen.dart';
import 'package:amazon_clone/common/home_page.dart';
import 'package:amazon_clone/common/auth/screens/auth_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AuthScreen(),
      );
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const HomePage(),
      );
    case AdminPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AdminPage(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProductScreen(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}

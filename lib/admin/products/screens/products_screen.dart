import 'package:amazon_clone/admin/products/screens/add_prodcut_screen.dart';
import 'package:flutter/material.dart';

class PProductsScreen extends StatefulWidget {
  const PProductsScreen({super.key});

  @override
  State<PProductsScreen> createState() => _PProductsScreenState();
}

class _PProductsScreenState extends State<PProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Products'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add a Product',
        onPressed: navigateToAddProdcut,
        child: const Icon(Icons.add),
      ),
    );
  }

  void navigateToAddProdcut() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
}

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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:amazon_clone/admin/products/screens/add_prodcut_screen.dart';
import 'package:amazon_clone/admin/services/admin_service.dart';
import 'package:amazon_clone/common/account/widgets/single_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final AdminService adminService = AdminService();

  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : products!.isEmpty
              ? const Center(
                  child: Text('Empty'),
                )
              : SingleChildScrollView(
                  child: GridView.builder(
                    primary: false,
                    cacheExtent: 8,
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: SingleProduct(
                              imageUrl: productData.images.first,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.delete_outline),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
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

  Future<void> fetchAllProducts() async {
    final productList = await adminService.fetchAllProducts(context: context);

    setState(() {
      products = productList;
    });
  }
}

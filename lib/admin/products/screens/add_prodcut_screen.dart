import 'dart:io';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  String? categoryValue = GlobalVarialbles.productCateguries.first;
  List<File> selectedImages = [];
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
          title: const Text('Add Product'),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
            child: Column(
              children: [
                selectedImages.isNotEmpty
                    ? CarouselSlider(
                        items: selectedImages.map((file) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              file,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 200,
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.folder_open, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  'Select Prodcut Images',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _descriptionController,
                  hintText: 'Description',
                  maxLines: 6,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: _quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    value: categoryValue,
                    items: GlobalVarialbles.productCateguries
                        .map(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        categoryValue = value;
                      });
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Sell',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
  }

  void selectImages() async {
    List<File> images = await pickImageFiles();
    setState(() {
      selectedImages.clear();
      selectedImages.addAll(images);
    });
  }
}

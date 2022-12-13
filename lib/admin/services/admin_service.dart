import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/cloudinary_client.dart';
import 'package:amazon_clone/constants/extensions.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/http_handler.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminService {
  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required int price,
    required int quantity,
    required String category,
    required List<File> imageFiles,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      List<String> imageUrls = [];

      for (var img in imageFiles) {
        CloudinaryResponse cloudinaryResponse =
            await CloudinaryClient.instance.uploadProductImage(img, name);
        imageUrls.add(cloudinaryResponse.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      http.Response res = await http.post(
        Uri.parse('${GlobalVarialbles.apiBaseUrl}/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: product.toJson(),
      );

      handleHttpResponse(
        response: res,
        context: context,
        onSuccess: () {
          context.showSnackBar(message: 'Product added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts({
    required BuildContext context,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('${GlobalVarialbles.apiBaseUrl}/admin/products'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token,
          });

      handleHttpResponse(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
                //     jsonEncode({
                //   "_id": "639835f01adff06cba9da73e",
                //   "name": "first. product",
                //   "description": "djznnz have n,ndhdhhc",
                //   "images": [
                //     "https://res.cloudinary.com/vn4vcthms/image/upload/v1670919651/amazon_clone/first.%20product%20/h1paphkx4e6tyzlj78eu.jpg"
                //   ],
                //   "quantity": 23,
                //   "price": 3737,
                //   "category": "Mobiles",
                //   "__v": 0
                // }),
              ),
            );
          }
        },
      );
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
    return productList;
  }
}

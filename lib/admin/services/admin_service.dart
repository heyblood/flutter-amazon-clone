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
    required double price,
    required double quantity,
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

      http.Response response = await http.post(
        Uri.parse('${GlobalVarialbles.apiBaseUrl}/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.token,
        },
        body: product.toJson(),
      );

      handleHttpResponse(
        response: response,
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
}

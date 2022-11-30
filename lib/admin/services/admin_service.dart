import 'dart:io';

import 'package:amazon_clone/constants/extensions.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';

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
    try {
      final cloudinary = CloudinaryPublic('dr9dix1oh', 'n2jybjww');
      List<String> imageUrls = [];

      for (var img in imageFiles) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(
            img.path,
            resourceType: CloudinaryResourceType.Image,
            folder: name,
          ),
        );
        imageUrls.add(response.secureUrl);

        Product product = Product(
          name: name,
          description: description,
          price: price,
          quantity: quantity,
          category: category,
          images: imageUrls,
        );
      }
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }
}

import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';

/// Singleton [CloudinaryClient] to upload images
class CloudinaryClient {
  late CloudinaryPublic cloudinary;

  static final instance = CloudinaryClient._();
  CloudinaryClient._() {
    cloudinary = CloudinaryPublic('dr9dix1oh', 'n2jybjww');
  }

  /// folder in Cloudinary's media library
  String _getFolderPath(String folder) {
    return 'amazon_clone/$folder';
  }

  /// Upload the [image] to [path] folder in Cloudinary
  Future<CloudinaryResponse> uploadProductImage(File image, String path) async {
    CloudinaryResponse response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(
        image.path,
        resourceType: CloudinaryResourceType.Image,
        folder: _getFolderPath(path),
      ),
    );
    return response;
  }
}

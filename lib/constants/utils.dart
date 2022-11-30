import 'dart:io';

import 'package:amazon_clone/constants/extensions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<List<File>> pickImageFiles(BuildContext context) async {
  List<File> files = [];
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      for (var file in result.files) {
        files.add(File(file.path!));
      }
    }
  } catch (e) {
    context.showErrorSnackBar(message: e.toString());
  }
  return files;
}

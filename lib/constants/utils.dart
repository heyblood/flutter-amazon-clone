import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

Future<List<File>> pickImageFiles() async {
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
    debugPrint(e.toString());
  }
  return files;
}

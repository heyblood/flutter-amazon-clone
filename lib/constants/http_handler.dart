import 'dart:convert';

import 'package:amazon_clone/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void handleHttpResponse({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      context.showSnackBar(message: jsonDecode(response.body)['msg']);
      break;
    case 500:
      context.showErrorSnackBar(message: jsonDecode(response.body)['error']);
      break;
    default:
      context.showErrorSnackBar(message: jsonDecode(response.body));
  }
}

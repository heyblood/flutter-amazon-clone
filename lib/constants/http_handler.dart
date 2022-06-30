import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart' as utils;
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
      utils.showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      utils.showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      utils.showSnackBar(context, jsonDecode(response.body));
  }
}

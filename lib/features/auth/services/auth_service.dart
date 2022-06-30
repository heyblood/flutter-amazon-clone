import 'package:amazon_clone/constants/http_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart'
    as global_variables;
import 'package:amazon_clone/constants/utils.dart' as utils;
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(name: name, email: email, password: password);
      http.Response res = await http.post(
          Uri.parse('${global_variables.url}/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      handleHttpResponse(
          response: res,
          context: context,
          onSuccess: () {
            utils.showSnackBar(context, 'Account created!');
          });
    } catch (e) {
      utils.showSnackBar(context, e.toString());
    }
  }
}

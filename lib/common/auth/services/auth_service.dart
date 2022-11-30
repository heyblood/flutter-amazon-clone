// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/admin/admin_page.dart';
import 'package:amazon_clone/common/home_page.dart';
import 'package:amazon_clone/constants/extensions.dart';
import 'package:amazon_clone/constants/http_handler.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          Uri.parse('${GlobalVarialbles.apiServerUrl}/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      handleHttpResponse(
          response: res,
          context: context,
          onSuccess: () {
            context.showSnackBar(message: 'Account created!');
          });
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('${GlobalVarialbles.apiServerUrl}/api/signin'),
          body: jsonEncode({
            'email': email,
            'password': password,
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      handleHttpResponse(
          response: res,
          context: context,
          onSuccess: () async {
            final prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);

            // FIXME: Null check operator used on a null value
            Future.delayed(Duration.zero, () {
              final user = Provider.of<UserProvider>(context).user;
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  user.type == 'user'
                      ? HomePage.routeName
                      : AdminPage.routeName,
                  (route) => false);
              // Navigator.pushReplacementNamed(context, HomePage.routeName);
            });
          });
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }

  // get user  data
  void getUserData({required BuildContext context}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString('x-auth-token', '');
        await prefs.remove('x-auth-token');
        return;
      }

      var tokenRes = await http.post(
          Uri.parse('${GlobalVarialbles.apiServerUrl}/api/verify-token'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });

      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        http.Response userRes = await http.get(
            Uri.parse('${GlobalVarialbles.apiServerUrl}/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      context.showErrorSnackBar(message: e.toString());
    }
  }
}

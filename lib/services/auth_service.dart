import 'dart:convert';
import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce_app/common/widgets/bottom_bar.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        password: password,
        email: email,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: jsonEncode(user.toJson()),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );

      void handleSignUpSuccess() {
        showSnackBar(
            context, 'Account created! Login with the same credentials');
      }

      if (!context.mounted) return;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: handleSignUpSuccess,
      );
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
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
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8'
        },
      );

      void handleSignInSuccess() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        if (!context.mounted) return;
        Provider.of<UserProvider>(context, listen: false).setUser(res.body);
        Navigator.pushNamedAndRemoveUntil(
          context,
          BottomBar.routeName,
          (route) => false,
        );
      }

      if (!context.mounted) return;

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: handleSignInSuccess,
      );
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
        token = ''; // Ensure token is set to an empty string
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );

        if (!context.mounted) return;
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      if (!context.mounted) return;
      showSnackBar(context, e.toString());
    }
  }
}

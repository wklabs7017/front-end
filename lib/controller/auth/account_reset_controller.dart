import 'dart:io';

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountResetController extends GetxController {
  var response;
  int? id;
  String? accessToken;
  final Dio dio = Dio();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.passwordReset}';

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // 이메일 형식을 검증하는 정규 표현식
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callResetPassword();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callResetPassword() async {
    try {
      var success = await resetPassword(
          id!, accessToken!, emailController.text.toString());
      if (success) {
        print('Password reset successfully');
      }
    } catch (e) {
      print('Error resetting password: $e');
    }
  }

  Future<bool> resetPassword(int id, String accessToken, String email) async {
    try {
      response = await dio.patch('$BASE_URL',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: {'email': email});

      if (response.statusCode == 200 || response.statusCode == 204) {
        print(response.statusCode);
      } else {
        print(response.statusMessage);
        print(response.data);
        print(emailController.text);
        print(id);
      }
      return true;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException: ${e.response}');

      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}

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

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userPasswordReset}';

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // 이메일 형식 및 길이를 검증하는 정규 표현식 수정
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$',
    );
    if (!emailRegex.hasMatch(value) || value.length < 3 || value.length > 511) {
      return 'Invalid email format or length';
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
      var success =
          await resetPassword(id!, accessToken!, emailController.text);
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
      print(email);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(emailController.text);

        print(response.statusCode);
      } else {
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

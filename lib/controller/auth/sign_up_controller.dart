import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController {
  var id;

  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final storage = const FlutterSecureStorage();
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.signUp}';

  Future<void> saveAccessToken(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id ?? '');
  }

  Future<int?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  String? userIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your ID';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your user name.';
    }
    return null;
  }

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

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }

    // 비밀번호 최소 길이
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // 숫자 포함 여부 검사
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    // 특수 문자 포함 여부 검사
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  void callSignUp() async {
    bool isSuccess = await signUp(
      userIdController.text,
      nameController.text,
      emailController.text,
      passwordController.text,
    );

    if (isSuccess) {
      // 성공 시 페이지 이동
      Get.offAllNamed('/signIn'); // 성공 시 이동할 페이지 경로
    } else {
      print('문제가 발생하였습니다. 관리자에게 문의해주세요.');
    }
  }

  Future<bool> signUp(
      String userId, String name, String email, String password) async {
    try {
      var res = await dio.post(BASE_URL, data: {
        'user_id': userId,
        'name': name,
        'email': email,
        'password': password,
      });
      if (res.statusCode == 201) {
        id = res.data;
        saveAccessToken(id);
        return true; // 성공 시 true 반환
      }
      print(res.statusCode);

      return false; // 상태 코드가 200이 아니거나 'status'가 'error'인 경우
    } on DioException catch (e) {
      print(e.message);
      return false; // 네트워크 오류 또는 기타 예외 발생 시
    }
  }

  @override
  void dispose() {
    userIdController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

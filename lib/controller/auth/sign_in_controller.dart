import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController {
  // String? accessToken;
  //String? refreshToken;

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.signIn}';

  String? userIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your ID';
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

  void callSignIn() async {
    bool isSuccess = await signIn(
      userIdController.text,
      passwordController.text,
    );

    if (isSuccess) {
      // 성공 시 페이지 이동
      Get.offAllNamed('/index'); // 성공 시 이동할 페이지 경로
    } else {
      // 로그인 실패 시 다이얼로그 표시
      _showLoginFailedDialog();
    }
  }

  void _showLoginFailedDialog() {
    showDialog(
      context: Get.context!, // Getx의 context 사용
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("로그인 실패"),
          content: Text("아이디 또는 비밀번호가 잘못되었습니다."),
          actions: <Widget>[
            TextButton(
              child: Text("닫기"),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> saveRefreshToken(String? token) async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    final storage = FlutterSecureStorage();
    return await storage.read(key: 'refresh_token');
  }

  Future<void> saveAccessToken(String? token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token ?? '');
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<void> saveId(int? id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id', id ?? -1);
  }

  Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  // signIn 메서드 내에서 호출
  Future<bool> signIn(String userId, String password) async {
    try {
      var res = await dio.post(BASE_URL, data: {
        'user_id': userId,
        'password': password,
      });
      print(res.statusCode);

      if (res.statusCode == 201) {
        var resData = res.data;
        print(res.statusCode);
        var refreshToken = res.data['refresh_token'];
        saveRefreshToken(refreshToken);
        var accessToken = res.data['access_token'];
        saveAccessToken(accessToken);

        saveId(res.data['id']);
        return true;
      }
      return false;
    } on DioException catch (e) {
      print(e.message);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

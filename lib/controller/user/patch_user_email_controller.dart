import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchUserEmailController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();
  final TextEditingController emailController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final String PATCH_EMAIL_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userEmail}';

  void handleFocusChange() {
    if (focusNode.hasFocus) {
      emailController.clear();
    }
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

  Future<bool> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      var success = callPatchUserEmail();
      if (success == true) {
        return true;
      }
      return true;
    } else {
      print('Access Token or ID is null');
      print('sdsdsd');
      return false;
    }
  }

  Future<bool?> callPatchUserEmail() async {
    bool? success =
        await patchUserEmail(id!, emailController.text!, accessToken!);
    return success!;
  }

  Future<bool?> patchUserEmail(int id, String email, String accessToken) async {
    try {
      var response = await dio.patch(
        '${PATCH_EMAIL_URL}?id=${id}',
        data: {
          'email': email,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken', // 헤더 수정
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.statusCode);

        return true;
      } else {
        // 서버 응답이 200이 아닌 경우
        print('서버 응답 오류: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      // Dio 오류 발생 시
      print('Dio 오류: ${e.message}');
      print(id);
      print(email);
      print(accessToken);
      return false;
    } catch (e) {
      //기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

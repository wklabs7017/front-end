import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchUserPasswordController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();
  final TextEditingController prevPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final FocusNode focusNode = FocusNode();

  final String PATCH_PASSWORD_URL =
      '${ApiRoutes.baseUrl}${ApiRoutes.userPassword}';

  void handleFocusChange() {
    if (focusNode.hasFocus) {
      prevPasswordController.clear();
      newPasswordController.clear();
    }
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

  Future<bool?> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      var success = callPatchUserPassword();
      if (success == true) {
        return true;
      }
      return true;
    } else {
      print('Access Token or ID is null');
      return false;
    }
  }

  Future<bool> callPatchUserPassword() async {
    bool? success = await patchUserPassword(id!, prevPasswordController.text!,
        newPasswordController.text!, accessToken!);

    return success!;
  }

  Future<bool?> patchUserPassword(int id, String prev_password,
      String new_password, String accessToken) async {
    try {
      var response = await dio.patch(
        '${PATCH_PASSWORD_URL}?id=${id}',
        data: {
          "prev_password": prev_password,
          "new_password": new_password,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken', // 헤더 수정
          },
        ),
      );

      if (response.statusCode == 200) {
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
      return false;
    } catch (e) {
      //기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

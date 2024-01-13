import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/controller/auth_controller/sign_up_controller.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class PatchUserEmailController extends GetxController {
  String initialEmail = '';
  final String PATCH_EMAIL_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userEmail}';
  final Dio dio = Dio();

  final TextEditingController emailController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void handleFocusChange() {
    if (focusNode.hasFocus) {
      emailController.clear();
    }
  }

  Future<bool> patchUserEmail(int id, String email) async {
    try {
      var res = await dio.patch(PATCH_EMAIL_URL, data: {
        'id': id,
        'email': email,
      });
      if (res.statusCode == 200) {
        return true;
      } else {
        // 서버 응답이 200이 아닌 경우
        print('서버 응답 오류: ${res.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      // Dio 오류 발생 시
      print('Dio 오류: ${e.message}');
      return false;
    } catch (e) {
      // 기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

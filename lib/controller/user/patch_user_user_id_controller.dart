import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchUserIDController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final TextEditingController userIdController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final String PATCH_USER_ID_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userId}';

  void handleFocusChange() {
    if (focusNode.hasFocus) {
      userIdController.clear();
    }
  }

  Future<bool> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPatchUserID();
      return true;
    } else {
      print('Access Token or ID is null');
      print('sdsdsd');
      return false;
    }
  }

  void callPatchUserID() async {
    await patchUserID(id!, userIdController.text!, accessToken!);
  }

  Future<bool?> patchUserID(int id, String userId, String accessToken) async {
    try {
      var response = await dio.patch(
        '${PATCH_USER_ID_URL}?id=${id}',
        data: {
          'user_id': userId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken', // 헤더 수정
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        // 서버 응답이 200이 아닌 경우
        print('패치 오류: ${response.statusCode}');

        return false;
      }
    } on DioException catch (e) {
      // Dio 오류 발생 시
      print('Dio 오류: ${e.message}');
      print('Dio 오류: ${e.response}');

      return false;
    } catch (e) {
      //기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchUserPrevillegeController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final String BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userPrivilege}';

  TextEditingController previllegeController = TextEditingController();

  Future<bool?> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      var success = callPatchUserPrevillege();
      if (success == true) return true;
    } else {
      print('Access Token or ID is null');
      print('sdsdsd');
      return false;
    }
  }

  Future<bool?> callPatchUserPrevillege() async {
    var success = await patchUserPrevillege(id!, accessToken!);
    return success;
  }

  Future<bool?> patchUserPrevillege(int id, String accessToken) async {
    try {
      var response = await dio.patch(
        '${BASE_URL}?id=${id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken', // 헤더 수정
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);
        // 이메일 변경 성공
        return true;
      } else {
        // 서버 응답이 200이 아닌 경우
        print('서버 응답 오류: ${response.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      // Dio 오류 발생 시
      print(e);

      return false;
    } catch (e) {
      //기타 오류 발생 시

      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

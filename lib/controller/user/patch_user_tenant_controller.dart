import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchUserTenantController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final String BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userTenant}';

  @override
  void onInit() {
    super.onInit();
    getAccessToken().then((token) {
      accessToken = token; // 토큰 저장
      getId().then((userId) {
        id = userId; // 사용자 ID 저장
        // 필요한 경우 추가 로직 수행
      });
    });
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  void callPatchUserTenant() async {
    await patchUserTenant(id!, accessToken!);
  }

  Future<bool?> patchUserTenant(int id, String accessToken) async {
    try {
      print(id);
      print(accessToken);
      var response = await dio.patch(
        '${BASE_URL}?id=${id}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken', // 헤더 수정
          },
        ),
      );
      if (response.statusCode == 200) {
        // 이메일 변경 성공
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
      print(accessToken);
      return false;
    } catch (e) {
      //기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

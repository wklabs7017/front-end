import 'package:get/get.dart';
import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetWorkLogListByCreatedAtController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final String GET_WORK_LOG_LIST_BY_CREATED_AT_URL =
      '${ApiRoutes.baseUrl}${ApiRoutes.getWorkListLogByCreatedAt}';

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

  void callgetWorkLogListByCreatedAt() async {
    // await getWorkLogListByCreatedAt(, accessToken!);
  }

  Future<Map<String, dynamic>> getWorkLogListByCreatedAt(
      int userId, DateTime createdAt, String accessToken) async {
    try {
      var dio = Dio(); // Dio 인스턴스 생성
      var response = await dio.get(
        GET_WORK_LOG_LIST_BY_CREATED_AT_URL, // API 엔드포인트 URL
        queryParameters: {
          'user_id': userId,
          'created_at': createdAt.toIso8601String(),
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken', // 헤더에 액세스 토큰 추가
          },
        ),
      );

      if (response.statusCode == 200) {
        // 요청이 성공적으로 처리되었을 때
        return response.data; // JSON 데이터 반환
      } else {
        // 서버 응답이 200이 아닌 경우
        print('서버 응답 오류: ${response.statusCode}');
        return {};
      }
    } on DioError catch (e) {
// Dio 오류 발생 시
      print('Dio 오류: ${e.message}');
      return {};
    } catch (e) {
// 기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return {};
    }
  }
}

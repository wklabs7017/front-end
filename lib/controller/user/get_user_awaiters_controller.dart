import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserAwaitersController extends GetxController {
  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userAwaiters}';
  final Dio dio = Dio();
  String? accessToken;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
  }

  void initializeUser() async {
    await getAccessToken();
  }

  Future<void> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
  }

  Future<User?> getUserAwaiters(String? accessToken) async {
    if (accessToken == null) return null;
    try {
      final response = await dio.get(
        '${BASE_URL}', // API 엔드포인트 수정
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return User.fromJson(response.data);
      } else {
        print('서버 응답 오류: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('API 요청 오류: ${e.message}');
    } catch (e) {
      print('예외 발생: $e');
    }
    return null;
  }
}

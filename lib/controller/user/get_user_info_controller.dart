import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfoController extends GetxController {
  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.user}';
  final Dio dio = Dio();
  User? userInformation;
  int? id;
  String? accessToken;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initializeData();
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      fetchUserInfo();
    } else {
      print('Access Token or ID is null');
      print('sdsdsd');
    }
  }

  void callPatchUserPassword() async {
    await fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    try {
      final userInfo = await getUserInformation(id!, accessToken);
      if (userInfo != null) {
        userInformation = userInfo;
        update(); // UI 업데이트
      }
    } catch (e) {
      print('사용자 정보를 불러오는 데 실패했습니다: $e');
    }
  }

  Future<User?> getUserInformation(int id, String? accessToken) async {
    if (accessToken == null) return null;
    try {
      final response = await dio.get(
        '$BASE_URL?id=${id}', // API 엔드포인트 수정
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        print(response.statusCode);
        print(response.data);
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

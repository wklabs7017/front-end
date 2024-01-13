import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetUserInfoController extends GetxController {
  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.user}';

  final Dio dio = Dio();

  Future<User?> getUserInformation(int userId) async {
    try {
      final response = await dio.get(
        BASE_URL,
        queryParameters: {'id': userId},
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
    } on DioError catch (e) {
      print('API 요청 오류: ${e.message}');
    }
    return null;
  }
}

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefreshController extends GetxController {
  final Dio dio = Dio();
  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.refresh}';

  final storage = FlutterSecureStorage();

  Future<void> saveRefreshToken(String? token) async {
    await storage.write(key: 'new_refresh_token', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await storage.read(key: 'new_refresh_token');
  }

  Future<String?> getNewRefreshToken() async {
    try {
      var res = await dio.post(BASE_URL, data: {});
      if (res.statusCode == 201) {
        var resData = res.data;
        await saveRefreshToken(resData['refresh_token']);
      }
    } on DioException catch (e) {
      print(e.message);
    }
  }
}

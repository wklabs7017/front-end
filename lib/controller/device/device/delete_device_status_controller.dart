import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteDeviceStautsController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.deleteDevice}';

  Future<List<void>?> deleteDevice(int id, String accessToken) async {
    try {
      // Making a GET request to the API
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      // Checking if the response status code is 200 (OK) and data is not null
      if (response.statusCode == 200 && response.data != null) {
        print(response.statusCode);
      } else {
        throw Exception('Failed to delete Device status');
      }
    } catch (e) {
      print('Exception: $e');
      throw e;
    }
  }

  void initializeData(int deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      await deleteDevice(deviceId, accessToken!);
    } else {
      print('Access Token 또는 ID가 null입니다.');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

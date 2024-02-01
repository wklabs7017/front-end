import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/model/task.dart';
import 'package:bsn_v2/model/task_devices.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteTaskDevicesController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  int deviceId = 0;

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.deleteTaskDevicesStatus}';

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callDeleteTaskDevicesStatus();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callDeleteTaskDevicesStatus() async {
    try {
      var taskDevices =
          await deleteTaskDevicesStatus(id!, deviceId, accessToken!);
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<void> deleteTaskDevicesStatus(
      int id, int deviceId, String accessToken) async {
    try {
      var response = await dio.delete(
        '$BASE_URL?id=${id}',
        queryParameters: {
          'id': id,
          'device_id': deviceId,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        print('Data deleted successfully');
        // 성공 로직 처리
      } else {
        print('Failed to delete data');
        // 오류 처리 로직
      }
    } on DioError catch (e) {
      print('DioError: ${e.message}');
      // Dio 오류 처리
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

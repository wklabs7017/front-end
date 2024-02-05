import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchDeviceAgvBatteryLevelController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL =
      '${ApiRoutes.baseUrl}${ApiRoutes.patchDeviceAgvBatteryLevel}';

  TextEditingController batteryLevelController = TextEditingController();
  void initializeData(int deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPatchDeviceAgvBatteryLevel(deviceId);
      update();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callPatchDeviceAgvBatteryLevel(int deviceId) async {
    try {
      int battery_level =
          int.tryParse(batteryLevelController.text) ?? 0; // 기본값으로 0 설정

// 이부분
      await patchDeviceAgvBatteryLevel(deviceId, accessToken!, battery_level)
          .then((value) => update());
    } catch (e) {
      print('Error fetching batter_level status: $e');
    }
  }

  Future<void> patchDeviceAgvBatteryLevel(
      int id, String accessToken, int batteryLevel) async {
    try {
      var response = await dio.patch(
        '$BASE_URL?id=$id',
        data: {
          'battery_level': batteryLevel,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.statusCode);
        print('battery_level');
      } else {
        throw Exception('Failed to load battery_level status. ');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException: ${e.response}');

      throw e;
    } catch (e) {
      print('Exception: $e');
      throw e;
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
  //
  // void _editSelectedRow() {
  //   // 추가: 수정 버튼 눌렀을 때 호출되는 함수
  //   if (selectedRowIndex != null) {
  //     // 선택된 행에 대한 수정 로직 구현
  //   }
  // }
  //
  // void _deleteSelectedRow() {
  //   // 추가: 삭제 버튼 눌렀을 때 호출되는 함수
  //   if (selectedRowIndex != null) {
  //     // 선택된 행에 대한 삭제 로직 구현
  //   }
  // }
}

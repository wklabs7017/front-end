import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/post_device_agv_status_controller.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchDeviceAgvModeController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();
  final getDeviceAgvController = Get.find<GetDeviceAgvStatusController>();

  TextEditingController modeController = TextEditingController();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.patchDeviceAgvMode}';

  @override
  void onInit() {
    super.onInit();
  }

  void initializeData(int deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPatchDeviceAgvMode(deviceId);
    } else {
      print('Access Token or ID is null');
    }
  }

  void callPatchDeviceAgvMode(int deviceId) async {
    try {
      await patchDeviceAgvMode(deviceId!, accessToken!, modeController.text);
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<void> patchDeviceAgvMode(
      int id, String accessToken, String mode) async {
    try {
      var response = await dio.patch(
        '$BASE_URL?id=$id',
        data: {
          'mode': mode,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
        throw Exception('Failed to patch Device Name.');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');

      throw e;
    } catch (e) {
      print('Exception: $e');

      throw e;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

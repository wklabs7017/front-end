import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchDeviceConveyorStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  TextEditingController statusController = TextEditingController();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.patchDeviceConveyorStatus}';

  Future<void> initializeData(int deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPatchDeviceConveyorStatus(deviceId);
      update();
    } else {
      print('Access Token or ID is null');
    }
  }

  callPatchDeviceConveyorStatus(int deviceId) async {
    try {
      await patchDeviceConveyorStatus(
          deviceId!, accessToken!, statusController.text);
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<void> patchDeviceConveyorStatus(
      int id, String accessToken, String status) async {
    try {
      var response = await dio.patch(
        '$BASE_URL?id=$id',
        data: {
          'status': status,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.statusCode);
      } else {
        throw Exception('Failed to load SmartRack status');
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

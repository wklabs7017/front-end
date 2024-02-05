import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchDeviceAgvDriveDistanceController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL =
      '${ApiRoutes.baseUrl}${ApiRoutes.patchDeviceAgvDriveDistance}';

  TextEditingController driveDistanceController = TextEditingController();

  void initializeData(int deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPatchDeviceAgvDriveDistance(deviceId);
      update();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callPatchDeviceAgvDriveDistance(int deviceId) async {
    try {
      int driveDistance =
          int.tryParse(driveDistanceController.text) ?? 0; // 기본값으로 0 설정

      await patchDeviceAgvDriveDistance(deviceId, accessToken!, driveDistance);
    } catch (e) {
      print('Error fetching drivedistance status: $e');
    }
  }

  Future<void> patchDeviceAgvDriveDistance(
      int id, String accessToken, int driveDistance) async {
    try {
      var response = await dio.patch(
        '$BASE_URL?id=$id',
        data: {
          'distance': driveDistance,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.statusCode);
        print('drive_distance');
      } else {
        throw Exception('Failed to load SmartRack status');
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

  @override
  void dispose() {
    super.dispose();
  }
}

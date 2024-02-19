import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDeviceCobotStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  DateTime? equippedAt;

  int? tenantId = 2;

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.postDeviceCobot}';

  TextEditingController modelNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController manufacturerNameController = TextEditingController();
  TextEditingController tenantIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController modeController = TextEditingController();

  Future<void> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      await callPostDeviceCobotStatus();
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<void> callPostDeviceCobotStatus() async {
    equippedAt = DateTime.now(); // 현재 시각으로 업데이트
    int? tenantId = int.tryParse(tenantIdController.text);

    try {
      if (tenantId != null) {
        await postDeviceCobotStatus(
          id!,
          accessToken!,
          modelNameController.text,
          nameController.text,
          equippedAt ?? DateTime.now(),
          manufacturerNameController.text,
          tenantId,
          statusController.text,
          modeController.text,
        );
      } else {
        print('Invalid tenant ID');
        // Handle the case where the tenant ID is not a valid integer.
      }
    } catch (e) {
      print('Error fetching status: $e');
    }
  }

  Future<void> postDeviceCobotStatus(
      int id,
      String accessToken,
      String modelName,
      String name,
      DateTime equippedAt,
      String manufacturerName,
      int tenantId,
      String status,
      String mode) async {
    try {
      var response = await dio.post(
        '$BASE_URL?id=$id',
        data: {
          'model_name': modelName,
          'name': name,
          'equipped_at': equippedAt.toIso8601String(),
          'manufacturer_name': manufacturerName,
          'tenant_id': tenantId,
          'status': status,
          'mode': mode,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 201) {
        print(response.statusCode);
      } else {
        print(response.statusCode);
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

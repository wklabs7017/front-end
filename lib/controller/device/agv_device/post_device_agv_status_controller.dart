import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDeviceAgvStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  DateTime? equippedAt = DateTime.now();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.postDeviceAgv}';

  TextEditingController modelNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController manufacturerNameController = TextEditingController();
  TextEditingController manufacturerName2Controller = TextEditingController();

  TextEditingController statusController = TextEditingController();
  TextEditingController modeController = TextEditingController();

  TextEditingController tenantIdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeData();
    update();
  }

  Future<void> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      await callPostDeviceAgvStatus();
      update();
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<void> callPostDeviceAgvStatus() async {
    equippedAt = DateTime.now(); // 현재 시각으로 업데이트
    int? tenantId = int.tryParse(tenantIdController.text);

    try {
      await postDeviceAgvStatus(
        id!,
        accessToken!,
        modelNameController.text,
        nameController.text,
        equippedAt ?? DateTime.now(),
        manufacturerName2Controller.text,
        tenantId ?? 0,
        statusController.text,
        modeController.text,
      );
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<void> postDeviceAgvStatus(
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
        throw Exception('Failed to load agv status');
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

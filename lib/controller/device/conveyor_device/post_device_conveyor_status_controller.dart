import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostDeviceConveyorStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  DateTime? equippedAt;

  int? tenantId;

  int? speed;

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.postDeviceConveyor}';

  TextEditingController modelNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController manufacturerNameController = TextEditingController();
  TextEditingController tenantIdController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController speedController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeData();
  }

  Future<void> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      await callPostDeviceConveyorStatus();
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<void> callPostDeviceConveyorStatus() async {
    equippedAt = DateTime.now(); // 현재 시각으로 업데이트
    int? tenantId = int.tryParse(tenantIdController.text);

    try {
      await postDeviceConveyorStatus(
        id!,
        accessToken!,
        modelNameController.text,
        nameController.text,
        equippedAt = DateTime.now(),
        manufacturerNameController.text,
        tenantId ?? 0,
        statusController.text,
        speed ?? 0,
      );
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<void> postDeviceConveyorStatus(
      int id,
      String accessToken,
      String modelName,
      String name,
      DateTime equippedAt,
      String manufacturerName,
      int tenantId,
      String status,
      int speed) async {
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
          'speed': speed,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 201) {
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

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceConveyorController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();
  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDevice}';

  var devices = <Device>[].obs;
  var filteredDevices = <Device>[].obs;

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
      await fetchDevicesInRange(1, 200, accessToken!);
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<void> fetchDevicesInRange(
      int startId, int endId, String accessToken) async {
    List<Device> allDevices = [];

    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var response = await getDeviceStatus(currentId, accessToken);
        if (response != null) {
          allDevices.add(response);
        }
      } catch (e) {
        print('Error fetching conveyor devices status for ID $currentId: $e');
      }
    }

    // 모든 디바이스 정보를 가져온 후 필터링
    List<Device> conveyorDevices =
        allDevices.where((device) => device.type == 'CONVEYOR').toList();
    filteredDevices.assignAll(conveyorDevices);
  }

  Future<Device> getDeviceStatus(int id, String accessToken) async {
    try {
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          return Device.fromJson(response.data);
        } else {
          throw Exception('Failed to load  conveyor devices status');
        }
      } else {
        throw Exception('Failed to load  conveyor devices status');
      }
    } catch (e) {
      print('Exception: $e');
      throw Exception('Failed to fetch device: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

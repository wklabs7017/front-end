import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/cobot.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceCobotStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDeviceCobot}';

  var cobotStatus = <Cobot>[].obs;

  var cobots = <Cobot>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    print(cobots.value);
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      fetchDevicesInRange(5, 500, accessToken!);
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<RxList<Cobot>> fetchDevicesInRange(
      int startId, int endId, String accessToken) async {
    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var response = await getDeviceCobotStatus(currentId, accessToken);
        if (response.isNotEmpty) {
          cobots.addAll(response);
        }
      } catch (e) {
        // 오류 발생 시 해당 ID를 건너뛰고 로그 출력
        print('Error fetching AGV status for ID $currentId: $e');
      }
    }

    return cobots;
  }

  Future<List<Cobot>> getDeviceCobotStatus(int id, String accessToken) async {
    try {
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        List<Cobot> cobotStatus = [];

        if (response.data is Map<String, dynamic>) {
          cobotStatus.add(Cobot.fromJson(response.data));
        } else if (response.data is List) {
          cobotStatus = (response.data as List)
              .map<Cobot>(
                  (data) => Cobot.fromJson(data as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Failed to load Device status');
        }

        return cobotStatus;
      } else {
        throw Exception('Failed to load Device status');
      }
    }
    // Catching any errors and printing them
    catch (e) {
      print('Exception: $e');
      throw e;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

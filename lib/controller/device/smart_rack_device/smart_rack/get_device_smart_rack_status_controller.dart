import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/converyor.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceSmartRakckStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDeviceSmartRack}';

  var smartRackStatus = <SmartRack>[].obs;

  var smartracks = <SmartRack>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    print(smartracks.value);
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      fetchDevicesInRange(1, 50, accessToken!);
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<RxList<SmartRack>> fetchDevicesInRange(
      int startId, int endId, String accessToken) async {
    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var response = await getDeviceSmartRackStatus(currentId, accessToken);
        if (response.isNotEmpty) {
          smartracks.addAll(response);
        }
      } catch (e) {
        // 오류 발생 시 해당 ID를 건너뛰고 로그 출력
        print('Error fetching AGV status for ID $currentId: $e');
      }
    }

    return smartracks;
  }

  Future<List<SmartRack>> getDeviceSmartRackStatus(
      int id, String accessToken) async {
    try {
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        List<SmartRack> smartRackStatus = [];

        if (response.data is Map<String, dynamic>) {
          smartRackStatus.add(SmartRack.fromJson(response.data));
        } else if (response.data is List) {
          smartRackStatus = (response.data as List)
              .map<SmartRack>(
                  (data) => SmartRack.fromJson(data as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Failed to load Device status');
        }

        // Return the list of Device objects
        return smartRackStatus;
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

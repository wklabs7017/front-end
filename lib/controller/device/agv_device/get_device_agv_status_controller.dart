import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceAgvStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDeviceAgv}';

  var agvStatus = <AGV>[].obs;

  var agvs = <AGV>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    update();

    print(agvs.value);
  }

  void updateAgvs(List<AGV> newAgvs) {
    agvs.assignAll(newAgvs);
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

  Future<RxList<AGV>> fetchDevicesInRange(
      int startId, int endId, String accessToken) async {
    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var response = await getDeviceAGVStatus(currentId, accessToken);
        if (response.isNotEmpty) {
          agvs.addAll(response);
        }
      } catch (e) {
        // 오류 발생 시 해당 ID를 건너뛰고 로그 출력
        print('Error fetching AGV status for ID $currentId: $e');
      }
    }

    return agvs;
  }

  Future<List<AGV>> getDeviceAGVStatus(int id, String accessToken) async {
    try {
      // Making a GET request to the API
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      // Checking if the response status code is 200 (OK) and data is not null
      if (response.statusCode == 200 && response.data != null) {
        // Initializing an empty list to store Device objects
        List<AGV> agvStatus = [];

        // If the response data is a Map, it means there is a single device status.
        // Convert this map to a Device object and add it to the list.
        if (response.data is Map<String, dynamic>) {
          agvStatus.add(AGV.fromJson(response.data));
        }
        // If the response data is a List, iterate over it and
        // convert each item to a Device object and add to the list.
        else if (response.data is List) {
          agvStatus = (response.data as List)
              .map<AGV>((data) => AGV.fromJson(data as Map<String, dynamic>))
              .toList();
        }
        // If the data is neither a Map nor a List, throw an exception.
        else {
          throw Exception('Failed to load Device status');
        }

        // Return the list of Device objects
        return agvStatus;
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

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/converyor.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDeviceConveyorStatusController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDeviceConveyor}';

  var conveyorStatus = <Conveyor>[].obs;

  var conveyors = <Conveyor>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeData();
    print(conveyors.value);
  }

  Future<void> initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      conveyors.clear();

      fetchDevicesInRange(1, 50, accessToken!);
    } else {
      print('Access Token or ID is null');
    }
  }

  Future<RxList<Conveyor>> fetchDevicesInRange(
      int startId, int endId, String accessToken) async {
    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var response = await getDeviceConveyorStatus(currentId, accessToken);
        if (response.isNotEmpty) {
          conveyors.addAll(response);
        }
      } catch (e) {
        // 오류 발생 시 해당 ID를 건너뛰고 로그 출력
        print('Error fetching AGV status for ID $currentId: $e');
      }
    }

    return conveyors;
  }

  Future<List<Conveyor>> getDeviceConveyorStatus(
      int id, String accessToken) async {
    try {
      // Making a GET request to the API
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      // Checking if the response status code is 200 (OK) and data is not null
      if (response.statusCode == 200 && response.data != null) {
        // Initializing an empty list to store Device objects
        List<Conveyor> conveyorStatus = [];

        // If the response data is a Map, it means there is a single device status.
        // Convert this map to a Device object and add it to the list.
        if (response.data is Map<String, dynamic>) {
          conveyorStatus.add(Conveyor.fromJson(response.data));
        }
        // If the response data is a List, iterate over it and
        // convert each item to a Device object and add to the list.
        else if (response.data is List) {
          conveyorStatus = (response.data as List)
              .map<Conveyor>(
                  (data) => Conveyor.fromJson(data as Map<String, dynamic>))
              .toList();
        }
        // If the data is neither a Map nor a List, throw an exception.
        else {
          throw Exception('Failed to load Device status');
        }

        // Return the list of Device objects
        return conveyorStatus;
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

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDviceAgvStautsController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDeviceAgv}';

  var deviceAgvStauts = <AGV>[].obs;

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
      callGetDeviceStatus();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callGetDeviceStatus() async {
    try {
      var agv = await getDeviceAgvStatus(id!, accessToken!);
      deviceAgvStauts.value = agv;
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<List<AGV>> getDeviceAgvStatus(int id, String accessToken) async {
    try {
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        print(response.statusCode);
        List<dynamic> responseData = response.data;
        return responseData.map((data) => AGV.fromJson(data)).toList();
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
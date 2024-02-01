import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/console.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetConsoleLogStautsController extends GetxController {
  var selectedValue = 'Option1'.obs;
  List<String> options = ['Option1', 'Option2', 'Option3'];
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getDevice}';

  var consoleLog = <ConsoleLog>[].obs;

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
      // callGetDeviceStatus();
    } else {
      print('Access Token or ID is null');
    }
  }

  // void callGetDeviceStatus() async {
  //   try {
  //     var console = await getConsoleLogs(
  //         accessToken: accessToken!,
  //         levels: options,
  //         count: 10,
  //         to: DateTime(2001),
  //         from: DateTime(1970),
  //     skip: 0,
  //     userIds: ;
  //     consoleLog.value = console;
  //   } catch (e) {
  //     print('Error fetching SmartRack status: $e');
  //   }
  // }

  Future<List<ConsoleLog>> getConsoleLogs({
    required String accessToken,
    required List<String> levels,
    required DateTime to,
    required DateTime from,
    required List<int> userIds,
    required int count,
    required int skip,
  }) async {
    try {
      var response = await dio.get(
        '$BASE_URL',
        queryParameters: {
          'levels': levels,
          'to': to.toIso8601String(),
          'from': from.toIso8601String(),
          'user_id': userIds,
          'count': count,
          'skip': skip,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return (response.data as List)
            .map((item) => ConsoleLog.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to fetch console logs');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      throw e;
    }
  }
}

@override
void dispose() {
  //super.dispose();
}

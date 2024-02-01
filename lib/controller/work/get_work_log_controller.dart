import 'package:bsn_v2/model/console.dart';
import 'package:get/get.dart';
import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetWorkLogController extends GetxController {
  String? userId;

  DateTime? selectedDate;
  String? accessToken;
  final Dio dio = Dio();

  final String GET_WORK_LOG_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getWorkLog}';

  TextEditingController userIdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getAccessToken().then((token) {
      accessToken = token; // 토큰 저장
    });
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  void callgetWorkLog() async {
    //await getConsoleLogs(userIdController.text!, selectedDate!, accessToken!);
  }

  Future<List<ConsoleLog>> getConsoleLogs({
    required List<String> levels,
    required DateTime to,
    required DateTime from,
    required List<int> userIds,
    required int count,
    required int skip,
  }) async {
    var dio = Dio();
    var response = await dio.get(
      'https://your-api-base-url.com/api/log/console',
      queryParameters: {
        'levels': levels,
        'to': to.toIso8601String(),
        'from': from.toIso8601String(),
        'user_id': userIds,
        'count': count,
        'skip': skip,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> logsJson = response.data;
      return logsJson.map((json) => ConsoleLog.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load console logs');
    }
  }
}

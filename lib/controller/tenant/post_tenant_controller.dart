import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/points.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostTenantDetailController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final nameController = TextEditingController();
  final xController = TextEditingController();
  final yController = TextEditingController();

  final points = <Point>[].obs; // Observable 리스트

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.postTenant}';

  void addPoint() {
    double x = double.tryParse(xController.text) ?? 0.0;
    double y = double.tryParse(yController.text) ?? 0.0;
    points.add(Point(x: x, y: y));
    xController.clear();
    yController.clear();
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPostTenantDetail();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callPostTenantDetail() async {
    try {
      // PostTenantDetail 함수 호출
      await PostTenantDetail(nameController.text, points, accessToken!);
    } catch (e) {
      print('Error creating tenant: $e');
    }
  }

  Future<void> PostTenantDetail(
      String name, List<Point> points, String accessToken) async {
    var dio = Dio();

    try {
      final response = await dio.post(
        BASE_URL,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
        data: {
          'name': name,
          'area': {
            'points': points.map((point) => point.toJson()).toList(),
          },
        },
      );

      if (response.statusCode == 201) {
        // 요청이 성공적으로 처리되었을 때의 처리를 여기에 작성합니다.
        print('Tenant created successfully.');
      } else {
        // 오류 처리를 여기에 작성합니다.
        print('Failed to create tenant. Status code: ${response.statusCode} ');
      }
    } on DioError catch (e) {
      // DioError 처리
      if (e.response != null) {
        // 오류 응답이 있는 경우
        //print('Dio error: ${e.response!.data}');
        //print('Status code: ${e.response!.statusCode}');
      } else {
        // 오류 요청이 없는 경우 (요청 오류, 타임아웃 등)
        print('Dio error without response: ${e.message}');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

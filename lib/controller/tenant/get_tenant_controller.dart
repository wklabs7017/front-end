import 'dart:convert';

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/model/tenant.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetTenantDetailController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getTenant}';

  var tenantDetail = <Tenant>[].obs;
  var tenants = <Tenant>[].obs;

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
      fetchDevicesInRange(1, 50, accessToken!);
    } else {
      print('Access Token or ID is null');
      print('sdsdsd');
    }
  }

  Future<List<Tenant>> fetchDevicesInRange(
      int startId, int endId, String accessToken) async {
    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var response = await getTenantDetail(currentId, accessToken);
        if (response.isNotEmpty) {
          tenants.addAll(response);
        }
      } catch (e) {
        // 오류 발생 시 해당 ID를 건너뛰고 로그 출력
        print('Error fetching tenants status for ID $currentId: $e');
      }
    }

    return tenants;
  }

  Future<List<Tenant>> getTenantDetail(int id, String accessToken) async {
    try {
      var response = await dio.get(
        '$BASE_URL?id=$id',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.statusCode == 200 && response.data != null) {
        print(response.statusCode);
        print(response.data);

        // 서버 응답이 객체인 경우, 해당 객체를 단일 요소 리스트로 변환
        if (response.data is Map<String, dynamic>) {
          tenants.add(Tenant.fromJson(response.data));
        } else {
          throw Exception('Unexpected data format');
        }

        return tenantDetail;
      } else {
        throw Exception('Failed to load SmartRack status');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('DioException: ${e.error}');

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

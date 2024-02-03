import 'dart:convert';

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/manufacturer.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetManufacturerController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.getManufacturer}';

  var manufacturerDetail = <Manufacturer>[].obs;

  //var manufacturers = <Manufacturer>[].obs;

  var manufacturers = RxList<Manufacturer>();

  void addManufacturer(Manufacturer manufacturer) {
    manufacturers.add(manufacturer);
    update(); // Getx 상태 업데이트 함수 호출
  }

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
      fetchManufacturersInRange(5, 50, accessToken!);
    } else {
      print('Access Token or ID is null');
      print('sdsdsd');
    }
  }

  Future<List<Manufacturer>?> fetchManufacturersInRange(
      int startId, int endId, String accessToken) async {
    for (int currentId = startId; currentId <= endId; currentId++) {
      try {
        var fetchedManufacturers =
            await getManufacturerDetail(currentId, accessToken);
        manufacturers.addAll(fetchedManufacturers);
      } catch (e) {
        print('Error fetching device manufacturer for ID $currentId: $e');
      }
    }
    return manufacturers;
  }

  Future<List<Manufacturer>> getManufacturerDetail(
      int id, String accessToken) async {
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
          manufacturerDetail.add(Manufacturer.fromJson(response.data));
        } else {
          throw Exception('Unexpected data format');
        }

        return manufacturerDetail;
      } else {
        throw Exception('Failed to load manufacturer status');
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

import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/points.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostManufacturerController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.postManufacturer}';

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return '전화번호를 입력해주세요';
    }

    // 국제적으로 통용되는 전화번호 형식을 위한 정규 표현식
    // 예시: +1 234 567 8900, 123-456-7890, (123) 456-7890 등
    String pattern = r'(^\+?\d{1,3}[- ]?)?[\d -]{7,}$';
    RegExp regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return '올바른 전화번호 형식이 아닙니다';
    }

    return null; // 형식이 올바른 경우 null을 반환
  }

  void initializeData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token');
    id = prefs.getInt('id');

    if (accessToken != null && id != null) {
      callPostManufacurerDetail();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callPostManufacurerDetail() async {
    try {
      // PostTenantDetail 함수 호출
      await PostManufacurerDetail(
          nameController.text, contactController.text, accessToken!);
    } catch (e) {
      print('Error creating tenant: $e');
    }
  }

  Future<void> PostManufacurerDetail(
      String name, String contact, String accessToken) async {
    var dio = Dio();
    try {
      final response = await dio.post(
        BASE_URL,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
        data: {
          'name': name,
          'contact': contact,
        },
      );

      if (response.statusCode == 201) {
        print('Manufacturer created successfully.');
        // 여기에 성공 처리 로직을 추가할 수 있습니다.
      } else {
        // 실패한 경우의 처리
        print(
            'Failed to create manufacturer. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      // DioError 처리
      if (e.response != null) {
        // 오류 응답이 있는 경우
        print('Dio error: ${e.response!.data}');
        print('Status code: ${e.response!.statusCode}');
        print('Status code: ${e.response!.statusMessage}');
      } else {
        // 요청 오류, 타임아웃 등 오류 요청이 없는 경우
        print('Dio error without response: ${e.message}');
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

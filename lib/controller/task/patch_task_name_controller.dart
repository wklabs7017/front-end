import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatchTaskNameController extends GetxController {
  int? id;
  String? accessToken;
  final Dio dio = Dio();

  TextEditingController nameController = TextEditingController();

  final BASE_URL = '${ApiRoutes.baseUrl}${ApiRoutes.patchTaskName}';

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
      callPatchTaskName();
    } else {
      print('Access Token or ID is null');
    }
  }

  void callPatchTaskName() async {
    try {
      await patchTaskName(id!, accessToken!, nameController.text);
    } catch (e) {
      print('Error fetching SmartRack status: $e');
    }
  }

  Future<void> patchTaskName(int id, String accessToken, String name) async {
    try {
      var response = await dio.patch(
        '$BASE_URL?id=$id',
        data: {
          'name': name,
        },
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 201 && response.data != null) {
        print(response.statusCode);
      } else {
        throw Exception('Failed to patch Device Name.');
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

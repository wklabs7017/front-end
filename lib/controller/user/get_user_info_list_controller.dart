import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

class GetUserInfoListController extends GetxController {
  List<User>? data;
  @override
  void onInit() {
    super.onInit();
    getAccessToken().then((value) => fetchUserInformationListPage());
  }

  // 현재 페이지와 페이지당 표시할 항목 수
  var currentPage = 1.obs;
  var pageSize = 10;

  // 페이지네이션을 위한 사용자 목록
  var paginatedUserData = <User>[].obs;

  // ...

  void fetchUserInformationListPage() async {
    try {
      var users = await fetchUserInformationList(
        accessToken: accessToken,
        skip: currentPage.value,
        take: pageSize,
      );
      paginatedUserData.value = users;
    } catch (e) {
      // 에러 처리
    }
  }

  final Dio dio = Dio();

  final String USER_LIST_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userList}';

  String? accessToken;

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString(
        'access_token'); // Ensure you use the correct key to fetch the token
    return accessToken;
  }

  Future<List<User>> fetchUserInformationList({
    required int skip,
    required int take,
    String orderBy = 'ID',
    String sortingOrder = 'ASC',
    String? accessToken,
  }) async {
    try {
      final response = await dio.get(USER_LIST_URL,
          queryParameters: {
            'order_by': orderBy,
            'sorting_order': sortingOrder,
            'skip': skip,
            'take': take,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $accessToken', // accessToken을 헤더에 추가
            },
          ));

      if (response.statusCode == 200) {
        // 데이터 타입을 List<dynamic>으로 처리
        List<dynamic> responseData = response.data;
        // List<dynamic>을 List<User>로 변환
        List<User> userList = responseData
            .map((dynamic item) => User.fromJson(item as Map<String, dynamic>))
            .toList();
        data = userList;
        print(data);
        return userList;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

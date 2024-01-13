import 'package:bsn_v2/const/api_service/api_routes.dart';
import 'package:bsn_v2/model/user.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class PatchUserIdController extends GetxController {
  final String PATCH_USER_ID_URL = '${ApiRoutes.baseUrl}${ApiRoutes.userId}';
  final Dio dio = Dio();

  Future<bool> patchUserTenant(int id, String userId) async {
    try {
      var res = await dio
          .patch(PATCH_USER_ID_URL, data: {"id": 1, "user_id": userId});
      if (res.statusCode == 200) {
        return true;
      } else {
        // 서버 응답이 200이 아닌 경우
        print('서버 응답 오류: ${res.statusCode}');
        return false;
      }
    } on DioException catch (e) {
      // Dio 오류 발생 시
      print('Dio 오류: ${e.message}');
      return false;
    } catch (e) {
      // 기타 오류 발생 시
      print('알 수 없는 오류: $e');
      return false;
    }
  }
}

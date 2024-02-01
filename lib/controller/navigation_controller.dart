import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs; // 현재 선택된 인덱스를 관찰 가능한 변수로 선언

  void changeIndex(int index) {
    selectedIndex.value = index; // 인덱스 변경 메서드
  }
}

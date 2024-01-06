import 'package:bsn_v2/const/app_pages.dart';
import 'package:bsn_v2/view/screens/auth_screen/sigin_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_size/window_size.dart' as window_size;
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'view/screens/index_screen/index_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 윈도우 앱의 최소 크기 설정
  window_size.getWindowInfo().then((window) {
    if (window.screen != null) {
      final screenFrame = window.screen!.visibleFrame;
      final width = 1900.0;
      final height = 900.0;
      window_size.setWindowMinSize(Size(width, height));
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(345, 700), // 여기에 기준이 되는 디자인 크기를 입력합니다.
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          getPages: AppPages.routes, // GetX 라우트 사용
          //initialRoute: '/login', // 초기 라우트 지정 (예: '/login')
          home: LogInScreen(),
          // 다른 필요한 속성들...
        );
      },
    );
  }
}

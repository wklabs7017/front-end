import 'package:bsn_v2/view/screens/auth_screen/sign_up_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/index_screen.dart';
import 'package:bsn_v2/view/screens/auth_screen/sigin_in_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LogInScreen(),
    ),
    GetPage(
      name: '/index',
      page: () => IndexScreen(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignUpScreen(),
    ),
  ];
}

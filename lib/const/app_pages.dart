import 'package:bsn_v2/view/screens/auth_screen/account_reset_screen.dart';
import 'package:bsn_v2/view/screens/auth_screen/sign_in_screen.dart';
import 'package:bsn_v2/view/screens/auth_screen/sign_up_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/index_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: '/signIn',
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: '/signUp',
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: '/accountReset',
      page: () => AccountResetScreen(),
    ),
    GetPage(
      name: '/index',
      page: () => IndexScreen(),
    ),
  ];
}

import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/widget/container/custom_auth_screen_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui; // 흐림 효과를 위해 필요합니다.

class CantLogInScreen extends StatelessWidget {
  const CantLogInScreen({super.key});

  static const String route = '/can\'t login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(color: AppColors.primaryColor
                  //image: DecorationImage(
                  // image: AssetImage("asset/image/CITY.jpg"), // 여기에 이미지 경로 지정
//                ),
                  ),
            ),
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5), // 흐림 효과 적용
              child: Container(
                color: Colors.black.withOpacity(0.0), // 반투명 레이어 추가
              ),
            ),
            Positioned(
              top: 10, // 상단으로부터의 거리
              left: 10, // 왼쪽으로부터의 거리
              child: IconButton(
                icon: const Icon(Icons.arrow_back,
                    color: Colors.white), // 뒤로 가기 아이콘
                onPressed: () {
                  Navigator.pop(context); // 현재 화면을 종료하고 이전 화면으로 돌아갑니다.
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('CAN\'T SIGN IN?',
                    style: AppTextStyles.bold
                        .copyWith(fontSize: 40, color: Colors.white)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomAuthScreenContainer(
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.person,
                              color: Colors.white, size: 90),
                          Text('Sign Up',
                              style: AppTextStyles.bold
                                  .copyWith(color: Colors.white, fontSize: 24)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomAuthScreenContainer(
                      onTap: () {
                        Get.toNamed('/signup');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.email,
                              color: Colors.white, size: 90),
                          Text('Forgot ID or Password?',
                              style: AppTextStyles.bold
                                  .copyWith(color: Colors.white, fontSize: 20)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

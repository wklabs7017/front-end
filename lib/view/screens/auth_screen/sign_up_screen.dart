import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/screens/auth_screen/can\'t_login_screen.dart';
import 'package:bsn_v2/view/widget/button/custom_elevated_button.dart';
import 'package:bsn_v2/view/widget/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui; // 흐림 효과를 위해 필요합니다.

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static const String route = '/signup';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    String? _emailValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      // 이메일 형식을 검증하는 정규 표현식
      final emailRegex = RegExp(
        r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      );
      if (!emailRegex.hasMatch(value)) {
        return 'Invalid email format';
      }
      return null;
    }

    String? _passwordValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }

      // 비밀번호 최소 길이
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }

      // 숫자 포함 여부 검사
      if (!RegExp(r'[0-9]').hasMatch(value)) {
        return 'Password must contain at least one number';
      }

      // 특수 문자 포함 여부 검사
      if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
        return 'Password must contain at least one special character';
      }

      return null;
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.primaryColor
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
                icon: Icon(Icons.arrow_back, color: Colors.white), // 뒤로 가기 아이콘
                onPressed: () {
                  Navigator.pop(context); // 현재 화면을 종료하고 이전 화면으로 돌아갑니다.
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 600,
                    height: 450,
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius:
                            BorderRadius.circular(10) // 테두리 반경을 10으로 설정
                        ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 150.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 90),
                          Text('Enter ID/password ',
                              style: AppTextStyles.bold
                                  .copyWith(color: Colors.white, fontSize: 25)),
                          SizedBox(height: 10.h),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CustomTextFormField(
                                    controller: _emailController,
                                    hintText: 'Username',
                                    keyboardType: TextInputType.emailAddress,
                                    validator: _emailValidator,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomTextFormField(
                                    controller: _passwordController,
                                    hintText: 'Password',
                                    obscureText: true,
                                    validator: _passwordValidator,
                                  ),
                                  SizedBox(height: 10),
                                  CustomElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        Get.offAllNamed('/login');
                                      }
                                    },
                                    buttonName: 'Sign Up',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

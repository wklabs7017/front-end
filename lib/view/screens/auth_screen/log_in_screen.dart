import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/screens/auth_screen/cant_sign_in_screen.dart';
import 'package:bsn_v2/view/widget/button/custom_elevated_button.dart';
import 'package:bsn_v2/view/widget/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui; // 흐림 효과를 위해 필요합니다.

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    String? emailValidator(String? value) {
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

    String? passwordValidator(String? value) {
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 90),
                                Row(
                                  children: [
                                    const Icon(Icons.person,
                                        color: Colors.white, size: 35),
                                    const SizedBox(width: 10),
                                    Text('bsn-v2',
                                        style: AppTextStyles.bold.copyWith(
                                            color: Colors.white, fontSize: 25))
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    'Log in your account',
                                    style: AppTextStyles.thin.copyWith(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CustomTextFormField(
                                    controller: emailController,
                                    hintText: 'ID',
                                    keyboardType: TextInputType.emailAddress,
                                    //validator: emailValidator,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomTextFormField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    obscureText: true,
                                    validator: passwordValidator,
                                  ),
                                  const SizedBox(height: 10),
                                  CustomElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        Get.offAllNamed('/index');
                                      }
                                    },
                                    buttonName: 'Log In',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                      onTap: () {
                        Get.to(const CantLogInScreen());
                      },
                      child: Text('Can\'t log in?',
                          style: AppTextStyles.medium
                              .copyWith(color: Colors.white, fontSize: 15)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

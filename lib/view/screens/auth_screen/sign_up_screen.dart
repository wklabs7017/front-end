import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/auth/sign_up_controller.dart';
import 'package:bsn_v2/view/widget/button/custom_elevated_button.dart';
import 'package:bsn_v2/view/widget/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String route = '/signUp';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final signUpController = Get.find<SignUpController>();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600; // 600px를 기준으로 데스크탑 화면으로 간주

    // 컨테이너 크기를 화면에 맞춰 조정
    double containerWidth = isDesktop ? 600 : screenWidth * 0.9;
    double containerHeight = isDesktop ? 450 : screenWidth * 1.0;

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(color: AppColors.primaryColor),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7), // Adjust opacity as needed
                  ],
                ),
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
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: containerWidth,
                    height: containerHeight,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius:
                            BorderRadius.circular(10) // 테두리 반경을 10으로 설정
                        ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text('Enter your credentials!',
                                style: AppTextStyles.bold.copyWith(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          SizedBox(height: 2.h),
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(16), // 적절한 패딩 설정
                              child: Form(
                                key: signUpController.signUpFormKey,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 60),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      CustomTextFormField(
                                        maxLength: 10,
                                        controller:
                                            signUpController.nameController,
                                        hintText: 'name',
                                        validator:
                                            signUpController.nameValidator,
                                      ),
                                      SizedBox(height: 10),
                                      CustomTextFormField(
                                        maxLength: 15,
                                        controller:
                                            signUpController.userIdController,
                                        hintText: 'ID',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator:
                                            signUpController.userIdValidator,
                                      ),
                                      SizedBox(height: 10),
                                      CustomTextFormField(
                                        maxLength: 30,
                                        controller:
                                            signUpController.emailController,
                                        hintText: 'Email',
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator:
                                            signUpController.emailValidator,
                                      ),
                                      CustomTextFormField(
                                        maxLength: 20,
                                        controller:
                                            signUpController.passwordController,
                                        hintText: 'Password',
                                        obscureText: true,
                                        validator:
                                            signUpController.passwordValidator,
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(height: 10),
                                      CustomElevatedButton(
                                        onPressed: () {
                                          if (signUpController
                                              .signUpFormKey.currentState!
                                              .validate()) {
                                            signUpController.callSignUp();
                                          }
                                        },
                                        buttonName: 'Sign Up',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
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

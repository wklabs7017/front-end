import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/widget/button/custom_elevated_button.dart';
import 'package:bsn_v2/view/widget/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const String route = '/login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController _controller = TextEditingController();

  void _login() {
    if (formKey.currentState!.validate()) {
      // 유효성 검사를 통과하면 로그인 로직을 실행합니다.
      print(
          '로그인 버튼 눌림: Email: ${emailController.text}, Password: ${passwordController.text}');
      // 로그인 로직을 여기에 추가합니다. 예: 서버에 로그인 요청 등
    }
  }

  @override
  void dispose() {
    // 여기에서 컨트롤러들을 정리합니다.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600; // 600px를 기준으로 데스크탑 화면으로 간주

    // 컨테이너 크기를 화면에 맞춰 조정
    double containerWidth = isDesktop ? 600 : screenWidth * 0.9;
    double containerHeight = isDesktop ? 450 : screenWidth * 0.9;
    String? IdValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
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
      resizeToAvoidBottomInset: true, // 키보드 오버레이 방지
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
                          vertical: 10, horizontal: 60.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.person,
                                          color: Colors.white, size: 30.r),
                                      const SizedBox(width: 5),
                                      Align(
                                        alignment: AlignmentDirectional.center,
                                        child: Text('bsn-v2',
                                            style: AppTextStyles.bold.copyWith(
                                                color: Colors.white,
                                                fontSize: 30)),
                                      )
                                    ],
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.center,
                                    child: Text(
                                      'Log in your account',
                                      style: AppTextStyles.thin.copyWith(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Center(
                                  child: Container(
                                padding: EdgeInsets.all(16), // 적절한 패딩 설정
                                child: Form(
                                  key: formKey,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3.0.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        CustomTextFormField(
                                          onFieldSubmitted: (value) {
                                            _login();
                                          },
                                          maxLength: 30,
                                          controller: emailController,
                                          hintText: 'ID',
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: IdValidator,
                                        ),
                                        SizedBox(height: 10),
                                        CustomTextFormField(
                                          onFieldSubmitted: (value) {
                                            _login();
                                          },
                                          maxLength: 20,
                                          controller: passwordController,
                                          hintText: 'Password',
                                          obscureText: true,
                                          validator: passwordValidator,
                                        ),
                                        SizedBox(height: 10),
                                        CustomElevatedButton(
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              Get.offAllNamed('/index');
                                            }
                                          },
                                          buttonName: 'Log In',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.toNamed('/signUp');
                            },
                            child: Text('Sign Up',
                                style: AppTextStyles.medium.copyWith(
                                    color: Colors.white, fontSize: 15))),
                        Text('  |  ',
                            style: AppTextStyles.medium
                                .copyWith(color: Colors.white, fontSize: 15)),
                        InkWell(
                            onTap: () {
                              Get.toNamed('/forgotIdPassword');
                            },
                            child: Text('Forgot User name or Password?',
                                style: AppTextStyles.medium.copyWith(
                                    color: Colors.white, fontSize: 15)))
                      ],
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

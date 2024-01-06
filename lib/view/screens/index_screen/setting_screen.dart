import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_basic_app_bar.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomBasicAppBar(text: '설정'),
      body: Container(),
    );
  }
}

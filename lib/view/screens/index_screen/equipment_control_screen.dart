import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_basic_app_bar.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
// ... 기타 필요한 import ...

class EquipmentControlScreen extends StatelessWidget {
  const EquipmentControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면 너비에 따라 레이아웃을 결정
    double screenWidth = MediaQuery.of(context).size.width;
    bool isWideScreen = screenWidth > 600; // 예: 600px 이상을 넓은 화면으로 간주

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body:
          isWideScreen ? _buildWideScreenLayout() : _buildNarrowScreenLayout(),
    );
  }

  Widget _buildWideScreenLayout() {
    // 넓은 화면용 레이아웃 (Row 사용)
    return ListView(
      children: [
        SizedBox(height: 30),
        Row(
          children: [
            CustomBasicContainer(width: 110, height: 600),
            CustomBasicContainer(width: 224, height: 600),
            SizedBox(width: 8),
          ],
        ),
      ],
    );
  }

  Widget _buildNarrowScreenLayout() {
    // 좁은 화면용 레이아웃 (Column 사용)
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomBasicContainer(width: 350, height: 600),
            CustomBasicContainer(width: 350, height: 600),
          ],
        ),
      ),
    ]);
  }
}

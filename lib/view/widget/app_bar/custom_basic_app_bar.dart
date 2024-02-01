import 'package:bsn_v2/view/widget/button/custom_emergency_stop_button.dart';
import 'package:flutter/material.dart';
import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';

class CustomBasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final VoidCallback? onMenuTap; // 메뉴 버튼 탭 핸들러

  CustomBasicAppBar({Key? key, required this.text, this.onMenuTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600; // 600px를 기준으로 삼습니다.

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도
            spreadRadius: 2, // 그림자의 범위
            blurRadius: 4, // 흐림 정도
            offset: Offset(0, 2), // 수평 및 수직 방향으로의 그림자 위치
          ),
        ],
      ),
      child: AppBar(
        title: Text(
          text,
          style: AppTextStyles.bold
              .copyWith(fontSize: 20, color: AppColors.basicTextColor),
        ),
        actions: [CustomEmergencyStopButton()],
        backgroundColor: Colors.white, // 배경색 지정
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(AppBar().preferredSize.height); // AppBar의 기본 높이 사용
}

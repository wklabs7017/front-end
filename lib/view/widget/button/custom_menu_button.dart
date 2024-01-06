import 'package:flutter/material.dart';

import '../../../const/app_colors.dart';

class MenuButton extends StatelessWidget {
  String title;
  final Function(int) onTap;
  int index;
  bool isSelected; // 선택 여부를 나타내는 변수

  MenuButton({
    super.key,
    required this.title,
    required this.onTap,
    required this.index,
    this.isSelected = false, // 기본값으로 false 설정
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.all(16), // 내부 패딩 설정
        color: isSelected
            ? AppColors.secondaryColor
            : AppColors.primaryColor, // 배경색 변경
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : AppColors.menuTextColor, // 텍스트 색상 변경
          ),
        ),
      ),
    );
  }
}

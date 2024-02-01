import 'package:flutter/material.dart';
import '../../../const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';

class MenuButton extends StatefulWidget {
  String title;
  final IconData iconData; // Add iconData as a parameter
  Function() onTap;
  int? index;
  bool isSelected; // 선택 여부를 나타내는 변수

  MenuButton({
    super.key,
    required this.title,
    required this.iconData, // Add iconData to constructor
    required this.onTap,
    this.index,
    this.isSelected = false, // 기본값으로 false 설정
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        setState(() {
          widget.isSelected = !widget.isSelected; // 클릭 시 isSelected 상태 토글
        });
      },
      child: Container(
        padding: EdgeInsets.all(16),
        color: widget.isSelected
            ? AppColors.secondaryColor // 클릭됐을 때 세컨더리 컬러 사용
            : AppColors.primaryColor, // 클릭되지 않았을 때 프라이머리 컬러 사용
        child: Row(
          children: [
            Icon(
              widget.iconData, size: 13, // Use the iconData variable
              color: AppColors.menuTextColor, // Icon color
            ),
            SizedBox(width: 10),
            Text(
              widget.title,
              style: AppTextStyles.medium.copyWith(
                color: Colors.white, // Text color changes based on isSelected
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

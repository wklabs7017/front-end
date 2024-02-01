import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bsn_v2/const/app_colors.dart';

class CustomUserInfoListContainer extends StatelessWidget {
  final Widget? child;
  final double width;
  final int height;
  final String? text;

  CustomUserInfoListContainer({
    super.key,
    required this.width,
    required this.height,
    this.text = '',
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      margin: EdgeInsets.all(8.0), // Uniform margin around the container
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), // 그림자 색상
            blurRadius: 10.0, // 흐림 정도
            offset: Offset(0, 4), // 그림자의 위치
            spreadRadius: 0, // 그림자의 확산 정도
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lineColor,
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0), // Inner padding
        child: child,
      ),
    );
  }
}

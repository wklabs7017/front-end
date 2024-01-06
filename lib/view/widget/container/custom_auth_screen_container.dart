import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAuthScreenContainer extends StatelessWidget {
  Widget? child;
  void Function()? onTap;
  CustomAuthScreenContainer({super.key, this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: 60.w,
          height: 300.h,
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10) // 테두리 반경을 10으로 설정
              ),
          child: child),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBasicContainer extends StatelessWidget {
  Widget? child;
  double width;
  int height;
  String? text;
  CustomBasicContainer(
      {super.key,
      required this.width,
      required this.height,
      this.text = '',
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: child,
    );
  }
}

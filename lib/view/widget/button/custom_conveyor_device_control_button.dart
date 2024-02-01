import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomConveyorDeviceControlButton extends StatelessWidget {
  double width;
  double height;

  Color color;

  String text;
  CustomConveyorDeviceControlButton(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${text}',
              style: AppTextStyles.bold.copyWith(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

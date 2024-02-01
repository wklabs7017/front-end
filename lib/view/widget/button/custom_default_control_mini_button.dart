import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDefaultControlMiniButton extends StatelessWidget {
  double width;
  double height;

  Color color;

  String text;

  Widget? child;
  CustomDefaultControlMiniButton(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.text,
      this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFCACACA)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${text}',
              style: AppTextStyles.medium.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}

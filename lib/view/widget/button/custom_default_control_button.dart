import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDefaultControlButton extends StatelessWidget {
  double width;
  double height;

  Color color;

  String text;
  CustomDefaultControlButton(
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
        padding: const EdgeInsets.all(10),
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFCACACA)),
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: color,
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

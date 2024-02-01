import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDefaultControlContainer extends StatelessWidget {
  Widget? child;
  double width;
  double height;

  Color color;

  String text;
  CustomDefaultControlContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.color,
      required this.text,
      this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
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
    );
  }
}

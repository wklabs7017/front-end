import 'package:flutter/material.dart';
import '../../../const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';

class CustomSpeedControlButton extends StatelessWidget {
  const CustomSpeedControlButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 42,
      padding: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Color(0xFFF1F1F1),
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
          SizedBox(
            width: 66,
            child: Text(
              '+',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

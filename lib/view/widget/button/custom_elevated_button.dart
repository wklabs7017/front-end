import 'package:bsn_v2/const/App_colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? buttonName;

  CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.buttonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        '$buttonName',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: TextButton.styleFrom(
        elevation: 2.0, // 클릭 시 그림자 효과

        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.45,
          43,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: onPressed != null
            ? AppColors.primaryColor
            : Colors.grey, // 비활성 상태일 때 배경색 변경
      ),
    );
  }
}

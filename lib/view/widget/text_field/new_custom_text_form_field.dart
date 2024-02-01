import 'package:bsn_v2/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewCustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? hintText;
  final bool obscureText;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;

  final int? maxLength;

  NewCustomTextFormField({
    super.key,
    required this.maxLength,
    this.controller,
    this.validator,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      child: TextFormField(
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        cursorColor: Colors.white,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        style: const TextStyle(
          color: AppColors.basicTextColor, // 사용자 입력 텍스트의 색상을 지정합니다.

          // 여기에 다른 텍스트 스타일 속성을 추가할 수 있습니다.
        ),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: '',
          errorStyle: TextStyle(
            fontSize: 7.5, // 폰트 크기 조절
            color: Colors.red, // 폰트 색상 조절
          ),
          errorMaxLines: 1, // 에러 메시지 최대 줄 수 지정
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.basicTextColor),
          border: const OutlineInputBorder(),
          focusedBorder: focusedBorder ??
              const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)),
              ),
          focusedErrorBorder: focusedBorder ??
              const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)),
              ),
          enabledBorder: enabledBorder ??
              const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)),
              ),
          errorBorder: errorBorder ??
              const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFC0C0C0)),
              ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}

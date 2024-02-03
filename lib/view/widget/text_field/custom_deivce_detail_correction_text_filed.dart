import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDeviceDetailCorrectiontextField extends StatelessWidget {
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
  final String? labelText;

  CustomDeviceDetailCorrectiontextField({
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
    this.labelText, // 추가: 라벨 텍스트
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 200.w,
      child: TextFormField(
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        cursorColor: Colors.white,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        style: const TextStyle(
          color: Colors.black, // 사용자 입력 텍스트의 색상을 지정합니다.
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
          labelText: labelText, // 수정: 라벨 텍스트
          labelStyle: const TextStyle(color: Colors.white), // 수정: 라벨 텍스트 스타일
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          border: const UnderlineInputBorder(),
          focusedBorder: focusedBorder ??
              const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
          focusedErrorBorder: focusedBorder ??
              const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
          enabledBorder: enabledBorder ??
              const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
          errorBorder: errorBorder ??
              const UnderlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
        ),
        obscureText: obscureText,
      ),
    );
  }
}

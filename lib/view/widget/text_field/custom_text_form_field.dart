import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String? hintText;
  final bool obscureText;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;

  const CustomTextFormField({
    super.key,
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
      height: 60,
      child: TextFormField(
        cursorColor: Colors.white,
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        style: TextStyle(
          color: Colors.white, // 사용자 입력 텍스트의 색상을 지정합니다.
          // 여기에 다른 텍스트 스타일 속성을 추가할 수 있습니다.
        ),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
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

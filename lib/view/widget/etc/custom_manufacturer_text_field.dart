import 'package:flutter/material.dart';
import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';

class CustomManufacturerTextField extends StatelessWidget {
  final String label;
  final String? text;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final String? hintText;
  final bool obscureText;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;

  CustomManufacturerTextField({
    Key? key,
    required this.label,
    this.text,
    required this.controller,
    this.validator,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.obscureText = false,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(10)),
            width: 50,
            height: 40,
            child: Center(
              child: Text(
                label,
                style: AppTextStyles.medium
                    .copyWith(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 2,
          child: Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: AppColors.backgroundColor)),
            child: TextFormField(
              controller: controller,
              validator: validator,
              focusNode: focusNode,
              style: TextStyle(color: Colors.black, fontSize: 13),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                focusedBorder: focusedBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.backgroundColor),
                    ),
                enabledBorder: enabledBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.backgroundColor),
                    ),
                errorBorder: errorBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
              ),
              obscureText: obscureText,
            ),
          ),
        ),
      ],
    );
  }
}

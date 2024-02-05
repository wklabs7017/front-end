import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDecorationTextField extends StatelessWidget {
  String label;
  TextEditingController? controller;
  CustomDecorationTextField(
      {super.key, required this.label, required this.controller});

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${label}',
                      style: AppTextStyles.medium
                          .copyWith(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ),
              )),
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                controller: controller, // TextField를 관리할 컨트롤러
                decoration: InputDecoration(
                  // 입력 필드의 데코레이션을 정의합니다.
                  border: OutlineInputBorder(), // 외곽선 테두리를 추가합니다.
                ),
                style: AppTextStyles.medium.copyWith(
                  fontSize: 13,
                  color: Colors.black, // 글씨 색상을 검정색으로 지정합니다.
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

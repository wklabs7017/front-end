import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTenantListTileDetail extends StatelessWidget {
  String label;
  String text;
  CustomTenantListTileDetail(
      {super.key, required this.label, required this.text});

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
                  '${label}',
                  style: AppTextStyles.medium
                      .copyWith(color: Colors.white, fontSize: 14),
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
              child: Text(
                '    ${text}',
                style: AppTextStyles.medium.copyWith(fontSize: 13),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/widget/button/custom_emergency_stop_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  String text;
  CustomBasicAppBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('$text',
                style: AppTextStyles.medium.copyWith(fontSize: 20)),
          ),
          CustomEmergencyStopButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // 여기에서 AppBar의 높이를 조절할 수 있습니다.
}

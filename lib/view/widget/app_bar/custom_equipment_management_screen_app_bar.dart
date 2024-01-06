import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/widget/button/custom_emergency_stop_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEquipmentManagementScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomEquipmentManagementScreenAppBar({super.key});

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
            child: Text('장비 관리',
                style: AppTextStyles.medium.copyWith(fontSize: 20)),
          ),
          Center(
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Text('장비명 :  ',
                            style: AppTextStyles.medium.copyWith(fontSize: 16)),
                        Text('장비명',
                            style: AppTextStyles.medium.copyWith(fontSize: 16)),
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
              width: 180.w,
              height: 35,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(43),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          CustomEmergencyStopButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60); // 여기에서 AppBar의 높이를 조절할 수 있습니다.
}

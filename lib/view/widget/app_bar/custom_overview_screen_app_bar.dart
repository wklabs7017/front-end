import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/view/widget/button/custom_emergency_stop_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomOverviewScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomOverviewScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lineColor, // Border color
            width: 2.0, // Border width
          ),
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text('개요',
                  style: AppTextStyles.bold
                      .copyWith(fontSize: 20, color: AppColors.basicTextColor)),
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
                          Text('작업 :  ',
                              style:
                                  AppTextStyles.medium.copyWith(fontSize: 16)),
                          Text('{(작업내용)}',
                              style:
                                  AppTextStyles.medium.copyWith(fontSize: 16)),
                          Text('대기중',
                              style:
                                  AppTextStyles.medium.copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        CustomMiniTaskButton(
                            onTap: () {},
                            text: '작압 시작',
                            color: Color(0xFF9FDCA6)),
                        CustomMiniTaskButton(
                            onTap: () {},
                            text: '일시정지',
                            color: Color(0xFFFF6C6C)),
                        SizedBox(width: 7),
                        CustomMiniTaskButton(
                            onTap: () {},
                            text: '작업중지',
                            color: Color(0xFFFFCD6C)),
                        SizedBox(width: 7),
                      ],
                    ),
                  ],
                ),
                width: 180.w,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.lineColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.lineColor, width: 2.0)),
              ),
            ),
            CustomEmergencyStopButton(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70); // 여기에서 AppBar의 높이를 조절할 수 있습니다.
}

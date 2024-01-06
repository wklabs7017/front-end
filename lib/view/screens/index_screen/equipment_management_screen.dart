import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/screens/data_table/test.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_equipment_management_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:flutter/material.dart';

class EquipmentManagementScreen extends StatelessWidget {
  const EquipmentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomEquipmentManagementScreenAppBar(),
      body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomBasicContainer(
                  width: 200,
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTaskButton(text: '장비 추가'),
                      SizedBox(width: 5),
                      CustomTaskButton(text: '장비 제거'),
                      SizedBox(width: 5),
                      CustomTaskButton(text: '장비 선택'),
                      SizedBox(width: 5),
                      CustomTaskButton(text: '모두 선택'),
                      SizedBox(width: 5),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomBasicContainer(
                width: 390,
                height: 548,
                child: PaginatedDataTableDemo(),
              ),
            )
          ],
        ),
      ]),
    );
  }
}

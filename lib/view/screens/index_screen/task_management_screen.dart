import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_basic_app_bar.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:flutter/material.dart';

class TaskManagementScreen extends StatelessWidget {
  const TaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomBasicAppBar(text: '조작 메뉴'),
      body: ListView(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomBasicContainer(width: 400, height: 598),
          )
        ],
      ),
    );
  }
}

import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_basic_app_bar.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EquipmentControlScreen extends StatelessWidget {
  const EquipmentControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomBasicAppBar(text: '장비 제어'),
      body: ListView(
        children: [
          SizedBox(height: 40),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomBasicContainer(width: 80, height: 600),
                ),
                Expanded(child: CustomBasicContainer(width: 210, height: 600)),
                SizedBox(width: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}

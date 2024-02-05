import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/post_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_status_controller.dart';
import 'package:bsn_v2/controller/task/get_task_status_controller.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_button.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_container.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_mini_button.dart';
import 'package:bsn_v2/view/widget/button/custom_device_switch_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/etc/data_table/AGV/custom_agv_data_table.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_task_management_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_velocity_control_pannel.dart';
import 'package:bsn_v2/view/widget/etc/smart_rack_status_table.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagementScreen extends StatefulWidget {
  TaskManagementScreen({Key? key}) : super(key: key);

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final GetDeviceTaskController getDeviceTaskController =
      Get.find<GetDeviceTaskController>();
  DateTime selectedDate = DateTime.now(); // 선택된 날짜를 저장하는 상태 변수

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 600; // 데스크탑 화면으로 간주하는 기준

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isDesktop ? _buildDesktopLayout(screenWidth) : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout(double screenWidth) {
    return ListView(
      children: [
        SizedBox(height: 20),
        _buildEquipmentInfoSection(screenWidth),
        // 추가 섹션을 여기에 배치할 수 있습니다.
      ],
    );
  }

  Widget _buildEquipmentInfoSection(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderRow(),
          CustomBasicContainer(
            width: screenWidth,
            height: 150,
            child: CustomTaskManagementDataTable(
                task: getDeviceTaskController.taskStatus),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        });
    }

    return Row(
      children: [
        Text(
          '   작업 내용',
          style: AppTextStyles.bold.copyWith(color: Colors.black, fontSize: 25),
        ),
        Spacer(),
        CustomMiniTaskButton(
            color: AppColors.secondaryColor,
            onTap: () {
              _selectDate(context);
            },
            text: "${selectedDate}".split(' ')[0]),
        SizedBox(width: 10),
        _buildActionButton('작업 추가', null),
        SizedBox(width: 10),
        _buildActionButton('작업 수정', null),
        SizedBox(width: 10),
        _buildActionButton('작업 제거', null),
        SizedBox(width: 10),
      ],
    );
  }

  Widget _buildActionButton(String text, Widget? screen) {
    return CustomMiniTaskButton(
      onTap: () {
        if (screen != null) {
          Get.to(screen);
        }
      },
      text: text,
      color: AppColors.primaryColor,
    );
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomBasicContainer(width: 350, height: 300),
            // 모바일 레이아웃에 추가적인 컨테이너나 구성 요소를 여기에 배치할 수 있습니다.
          ],
        ),
      ),
    );
  }
}

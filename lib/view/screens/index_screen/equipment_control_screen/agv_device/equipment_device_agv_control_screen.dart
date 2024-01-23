import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/post_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_controller.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_button.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_container.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_mini_button.dart';
import 'package:bsn_v2/view/widget/button/custom_device_switch_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/etc/custom_agv_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_velocity_control_pannel.dart';
import 'package:bsn_v2/view/widget/etc/smart_rack_status_table.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipmentDeviceAgvControlScreen extends StatelessWidget {
  EquipmentDeviceAgvControlScreen({super.key});

  final getDeviceAgvController = Get.find<GetDeviceAgvStatusController>();
  final getDeviceController = Get.find<GetDeviceStautsController>();

  final patchDeviceAgvBatteryLevelController =
      Get.find<PatchDeviceAgvBatteryLevelController>();

  final patchDeviceAgvDriveDistanceController =
      Get.find<PatchDeviceAgvDriveDistanceController>();

  final patchDeviceAgvModeController = Get.find<PatchDeviceAgvModeController>();

  final postDeviceAgvStatusController =
      Get.find<PostDeviceAgvStatusController>();
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
    return ListView(children: [
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 3, // Adjust the flex factor as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('   Navigation',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 25)),
                  CustomBasicContainer(width: screenWidth * 0.3, height: 400),
                ],
              ),
            ),
            Expanded(
              flex: 2, // Adjust the flex factor as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('   장비 제어',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 25)),
                  CustomBasicContainer(
                    width: screenWidth * 0.4,
                    height: 400,
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('작동 모드',
                              style: AppTextStyles.bold.copyWith(fontSize: 17)),
                          SizedBox(height: 10),
                          CustomDeviceControlSwitchButton(),
                          SizedBox(height: 50),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDefaultControlButton(
                                  width: 85,
                                  height: 220,
                                  color: Colors.white,
                                  text: 'text'),
                              SizedBox(width: 5),
                              CustomDefaultControlContainer(
                                width: 129,
                                height: 220,
                                color: Colors.white,
                                text: 'text',
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomDefaultControlMiniButton(
                                        width: 104,
                                        height: 49,
                                        color: Colors.white,
                                        text: 'text'),
                                    SizedBox(height: 5),
                                    CustomDefaultControlMiniButton(
                                        width: 104,
                                        height: 49,
                                        color: Colors.white,
                                        text: 'text'),
                                    SizedBox(height: 5),
                                    CustomDefaultControlMiniButton(
                                        width: 104,
                                        height: 49,
                                        color: Colors.white,
                                        text: 'text')
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              CustomDefaultControlButton(
                                  width: 85,
                                  height: 220,
                                  color: Colors.white,
                                  text: 'text'),
                              SizedBox(width: 20),
                              CustomDefaultControlContainer(
                                  width: 85,
                                  height: 220,
                                  color: Colors.white,
                                  text: 'text',
                                  child: VelocityControlPanel(
                                    title: '선속도',
                                  )),
                              SizedBox(width: 20),
                              CustomDefaultControlContainer(
                                  width: 85,
                                  height: 220,
                                  color: Colors.white,
                                  text: 'text',
                                  child: VelocityControlPanel(
                                    title: '각속도',
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('   장비 정보',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                Spacer(),
                CustomMiniTaskButton(
                    onTap: () {}, text: '장비 추가', color: AppColors.primaryColor),
                SizedBox(width: 10),
                CustomMiniTaskButton(
                    onTap: () {}, text: '장비 수정', color: AppColors.primaryColor),
                SizedBox(width: 10),
                CustomMiniTaskButton(
                    onTap: () {}, text: '장비 제거', color: AppColors.primaryColor),
                SizedBox(width: 10),
              ],
            ),
            CustomBasicContainer(
                width: screenWidth,
                height: 150,
                child: CustomAgvStatusDataTable(
                    agvs: getDeviceAgvController.deviceAgvStauts,
                    devices: getDeviceController.deviceStauts)),
          ],
        ),
      ),
    ]);
  }

  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomBasicContainer(width: 350, height: 300),
            CustomBasicContainer(width: 350, height: 285),
            CustomBasicContainer(width: 350, height: 385),
            CustomBasicContainer(width: 350, height: 200),
            CustomBasicContainer(width: 350, height: 597),
          ],
        ),
      ),
    );
  }
}

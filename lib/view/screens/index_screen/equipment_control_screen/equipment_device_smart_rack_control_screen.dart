import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_status_controller.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/smart_rack_status_table.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipmentDeviceSmartRackControlScreen extends StatelessWidget {
  EquipmentDeviceSmartRackControlScreen({super.key});

  final getDeviceSmartRackController =
      Get.find<GetDeviceSmartRakckStatusController>();
  final getDeviceController = Get.find<GetDeviceSmartRackController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 1000; // 데스크탑 화면으로 간주하는 기준

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
                  Text('   육묘 상태 모니터링',
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
                  Text('   관수 제어',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 25)),
                  CustomBasicContainer(width: screenWidth * 0.4, height: 400),
                ],
              ),
            ),
            Expanded(
              flex: 2, // Adjust the flex factor as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(' 성장 LED 제어',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 25)),
                  CustomBasicContainer(
                      width: screenWidth * 0.4,
                      height: 400,
                      child: TextButton(
                          onPressed: () {
                            getDeviceController.initializeData();
                            getDeviceSmartRackController.initializeData();
                          },
                          child: Text('sdsd'))),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('   장비 정보',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                Spacer(),
                CustomMiniTaskButton(
                  onTap: () {},
                  text: '장비 추가',
                  color: AppColors.primaryColor,
                ),
                SizedBox(width: 10),
              ],
            ),
            CustomBasicContainer(
                width: screenWidth,
                height: 150,
                child: CustomSmartRackStatusDataTable(
                    smartRacks: getDeviceSmartRackController.smartracks,
                    devices: getDeviceController.filteredDevices)),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('   육묘 상태 모니터링',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(width: 350, height: 400),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('   관수 제어',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(width: 350, height: 400),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  성장 LED 제어',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(width: 350, height: 400),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('   장비 정보',
                        style: AppTextStyles.bold
                            .copyWith(color: Colors.black, fontSize: 25)),
                    Spacer(),
                    CustomMiniTaskButton(
                        width: 50,
                        height: 25,
                        onTap: () {},
                        text: '장비 추가',
                        color: AppColors.primaryColor),
                    SizedBox(width: 10),
                    CustomMiniTaskButton(
                        width: 50,
                        height: 25,
                        onTap: () {},
                        text: '장비 수정',
                        color: AppColors.primaryColor),
                    SizedBox(width: 10),
                    CustomMiniTaskButton(
                        width: 50,
                        height: 25,
                        onTap: () {},
                        text: '장비 제거',
                        color: AppColors.primaryColor),
                    SizedBox(width: 10),
                  ],
                ),
                CustomBasicContainer(
                  width: 350,
                  height: 300,
                  child: CustomSmartRackStatusDataTable(
                      smartRacks: getDeviceSmartRackController.smartracks,
                      devices: getDeviceController.filteredDevices),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

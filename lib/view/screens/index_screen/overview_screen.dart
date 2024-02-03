import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/console_log/get_console_log.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_status_controller.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/temperuture_humidity_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({super.key});

  var getDeviceSmartRackStatus;

  final getDeviceSmartRackController =
      Get.find<GetDeviceSmartRakckStatusController>();
  final getDeviceController = Get.find<GetDeviceStautsController>();
  final getSystemLogController = Get.find<GetConsoleLogStautsController>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 1000; // 데스크탑 화면으로 간주하는 기준

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return ListView(children: [
      SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(' 작업 관리',
                          style: AppTextStyles.bold
                              .copyWith(color: Colors.black, fontSize: 25)),
                      CustomBasicContainer(
                        width: 160,
                        height: 50,
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text('수행 중 작업 :',
                                style: AppTextStyles.bold.copyWith(
                                    color: Colors.black, fontSize: 5.sp)),
                            Text('  ',
                                style: AppTextStyles.bold.copyWith(
                                    color: Colors.black, fontSize: 20)),
                            Spacer(),
                            CustomMiniTaskButton(
                                width: 100,
                                height: 50,
                                onTap: () {},
                                text: '시작',
                                color: Color(0xFF9FDCA6)),
                            SizedBox(width: 10),
                            CustomMiniTaskButton(
                                width: 100,
                                height: 50,
                                onTap: () {},
                                text: '정지',
                                color: Color(0xFFFF6C6C)),
                            SizedBox(width: 10),
                            CustomMiniTaskButton(
                                width: 100,
                                height: 50,
                                onTap: () {},
                                text: '재개',
                                color: Color(0xFFFFCD6C)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(' 온·습도 추이',
                          style: AppTextStyles.bold
                              .copyWith(color: Colors.black, fontSize: 25)),
                      CustomBasicContainer(
                        width: 160,
                        height: 335,
                        child: TemperatureHumidityChart(),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(' 시스템 로그',
                          style: AppTextStyles.bold
                              .copyWith(color: Colors.black, fontSize: 25)),
                      CustomBasicContainer(
                        width: 160,
                        height: 145,
                        child: Column(
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center, // 세로축 기준으로 중앙 정렬
                                children: [
                                  Text(
                                    'log Filiter :',
                                    style: AppTextStyles.medium
                                        .copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // `Text`와 `DropdownButton` 사이의 공간
                                  Expanded(
                                    // `DropdownButton`을 Expanded로 감싸서 남은 공간을 채우도록 함
                                    child: DropdownButton<String>(
                                      value: getSystemLogController
                                          .selectedValue
                                          .value, // 이 값이 DropdownMenuItem 중 하나와 일치해야 함
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          getSystemLogController
                                              .selectedValue.value = newValue;
                                        }
                                      },
                                      items: getSystemLogController.options
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' 장비 현황',
                          style: AppTextStyles.bold
                              .copyWith(color: Colors.black, fontSize: 25)),
                      CustomBasicContainer(
                        width: 170,
                        height: 320,
                        child: CustomDeviceStatusDataTable(
                            devices: getDeviceController.devices),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(' 스마트 랙 현황',
                          style: AppTextStyles.bold
                              .copyWith(color: Colors.black, fontSize: 25)),
                      CustomBasicContainer(
                          width: 170,
                          height: 250,
                          child: CustomOverviewSmartRackStatusDataTable(
                              smartRacks:
                                  getDeviceSmartRackController.smartRackStatus))
                    ],
                  )
                ],
              ),
            )
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
            CustomBasicContainer(
              width: 350,
              height: 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  수행 중 작업 :',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 20)),
                  Text('  ',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 15)),
                  Row(
                    children: [
                      Spacer(),
                      CustomMiniTaskButton(
                          width: 80,
                          height: 30,
                          onTap: () {},
                          text: '시작',
                          color: Color(0xFF9FDCA6)),
                      SizedBox(width: 10),
                      CustomMiniTaskButton(
                          width: 80,
                          height: 30,
                          onTap: () {},
                          text: '정지',
                          color: Color(0xFFFF6C6C)),
                      SizedBox(width: 10),
                      CustomMiniTaskButton(
                          width: 80,
                          height: 30,
                          onTap: () {},
                          text: '재개',
                          color: Color(0xFFFFCD6C)),
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  온·습도 추이',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(
                  width: 350,
                  height: 300,
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: TemperatureHumidityChart()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  시스템 로그',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(
                    width: 350,
                    height: 340,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center, // 세로축 기준으로 중앙 정렬
                                children: [
                                  // `Text`와 `DropdownButton` 사이의 공간
                                  Text(
                                    'log Filiter :',
                                    style: AppTextStyles.medium
                                        .copyWith(fontSize: 16),
                                  ),
                                  SizedBox(
                                      width:
                                          10), // `Text`와 `DropdownButton` 사이의 공간
                                  Expanded(
                                    // `DropdownButton`을 Expanded로 감싸서 남은 공간을 채우도록 함
                                    child: DropdownButton<String>(
                                      value: getSystemLogController
                                          .selectedValue
                                          .value, // 이 값이 DropdownMenuItem 중 하나와 일치해야 함
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          getSystemLogController
                                              .selectedValue.value = newValue;
                                        }
                                      },
                                      items: getSystemLogController.options
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  장비 현황',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(
                    width: 350,
                    height: 300,
                    child: CustomDeviceStatusDataTable(
                        devices: getDeviceController.deviceStauts)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  스마트 랙 현황',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(
                  width: 350,
                  height: 300,
                  child: CustomOverviewSmartRackStatusDataTable(
                      smartRacks: getDeviceSmartRackController.smartRackStatus),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/patch_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/post_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/device/delete_device_status_controller.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_status_controller.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_container.dart';
import 'package:bsn_v2/view/widget/button/custom_device_switch_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_cobot_data_table.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_velocity_control_pannel.dart';
import 'package:bsn_v2/view/widget/etc/smart_rack_status_table.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipmentDeviceCobotControlScreen extends StatefulWidget {
  EquipmentDeviceCobotControlScreen({super.key});

  @override
  State<EquipmentDeviceCobotControlScreen> createState() =>
      _EquipmentDeviceCobotControlScreenState();
}

class _EquipmentDeviceCobotControlScreenState
    extends State<EquipmentDeviceCobotControlScreen> {
  final getDeviceCobotController = Get.find<GetDeviceCobotStatusController>();

// 올바른 컨트롤러 사용으로 수정
  final getDeviceController = Get.find<GetDeviceCobotController>();

  final postDeviceCobotController = Get.find<PostDeviceCobotStatusController>();

  final List<String> dropdownOptions1 = ['AUTO', 'MANUAL'];

  final List<String> dropdownOptions2 = ['ERROR', 'IDLE', 'RUNNING'];

  @override
  void initState() {
    // getDeviceCobotController.initializeData();
    // getDeviceController.initializeData();
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(label)),
          Expanded(
            flex: 2,
            child: TextField(controller: controller),
          ),
        ],
      ),
    );
  }

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
                  Text('   Navigation',
                      style: AppTextStyles.bold
                          .copyWith(color: Colors.black, fontSize: 25)),
                  CustomBasicContainer(
                    width: screenWidth * 0.3,
                    height: 400,
                    child: TextButton(
                        onPressed: () {
                          getDeviceCobotController.initializeData();
                          getDeviceController.initializeData();
                          print(getDeviceCobotController.cobots);
                          print(getDeviceController.devices);
                        },
                        child: Text('sdsd')),
                  ),
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
                                style:
                                    AppTextStyles.bold.copyWith(fontSize: 17)),
                            SizedBox(height: 10),
                            CustomDeviceControlSwitchButton(),
                            SizedBox(height: 50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomDefaultControlContainer(
                                        width: 85,
                                        height: 220,
                                        color: Colors.white,
                                        text: 'text',
                                        child: VelocityControlPanel(
                                          title: 'Axis 1',
                                        )),
                                    SizedBox(width: 10),
                                    CustomDefaultControlContainer(
                                        width: 85,
                                        height: 220,
                                        color: Colors.white,
                                        text: 'text',
                                        child: VelocityControlPanel(
                                          title: 'Axis 2',
                                        )),
                                    SizedBox(width: 10),
                                    CustomDefaultControlContainer(
                                        width: 85,
                                        height: 220,
                                        color: Colors.white,
                                        text: 'text',
                                        child: VelocityControlPanel(
                                          title: 'Axis 3',
                                        )),
                                    SizedBox(width: 10),
                                    CustomDefaultControlContainer(
                                        width: 85,
                                        height: 220,
                                        color: Colors.white,
                                        text: 'text',
                                        child: VelocityControlPanel(
                                          title: 'Axis 4',
                                        )),
                                    SizedBox(width: 10),
                                    CustomDefaultControlContainer(
                                        width: 85,
                                        height: 220,
                                        color: Colors.white,
                                        text: 'text',
                                        child: VelocityControlPanel(
                                          title: 'Axis 5',
                                        )),
                                    SizedBox(width: 10),
                                    CustomDefaultControlContainer(
                                      width: 85,
                                      height: 220,
                                      color: Colors.white,
                                      text: 'text',
                                      child: VelocityControlPanel(
                                        title: 'Axis 6',
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
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
                    onTap: () {
                      showDialog(
                        context: Get.context!,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('더블클릭 다이얼로그'),
                            content: Column(
                              children: [
                                buildTextField(
                                  label: 'Name:',
                                  controller:
                                      postDeviceCobotController.nameController,
                                ),
                                buildTextField(
                                  label: 'modelName:',
                                  controller: postDeviceCobotController
                                      .modelNameController,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: postDeviceCobotController
                                              .equippedAt ??
                                          DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2025),
                                    );

                                    if (pickedDate != null) {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                          postDeviceCobotController
                                                  .equippedAt ??
                                              DateTime.now(),
                                        ),
                                      );

                                      if (pickedTime != null) {
                                        postDeviceCobotController.equippedAt =
                                            DateTime(
                                          pickedDate.year,
                                          pickedDate.month,
                                          pickedDate.day,
                                          pickedTime.hour,
                                          pickedTime.minute,
                                        );
                                      }
                                    }
                                  },
                                  child: buildTextField(
                                    label: 'equipped_at:',
                                    controller: TextEditingController(
                                      text: postDeviceCobotController.equippedAt
                                              ?.toString() ??
                                          '',
                                    ),
                                  ),
                                ),
                                buildTextField(
                                  label: 'manufactruer_Name:',
                                  controller: postDeviceCobotController
                                      .manufacturerNameController,
                                ),
                                buildTextField(
                                  label: 'tenant_id:',
                                  controller: postDeviceCobotController
                                      .tenantIdController,
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Mode',
                                    // Add any additional styling or decoration as needed
                                  ),
                                  value: dropdownOptions2.contains(
                                          postDeviceCobotController
                                              .statusController.text)
                                      ? postDeviceCobotController
                                          .statusController.text
                                      : null,
                                  items: dropdownOptions2.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      postDeviceCobotController
                                          .statusController.text = newValue;
                                    }
                                  },
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Mode',
                                    // Add any additional styling or decoration as needed
                                  ),
                                  value: dropdownOptions1.contains(
                                          postDeviceCobotController
                                              .modeController.text)
                                      ? postDeviceCobotController
                                          .modeController.text
                                      : null,
                                  items: dropdownOptions1.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      postDeviceCobotController
                                          .modeController.text = newValue;
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    postDeviceCobotController.initializeData();
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // 다이얼로그 닫기
                                },
                                child: Text('확인'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    text: '장비 추가',
                    color: AppColors.primaryColor),
                SizedBox(width: 10),
                SizedBox(width: 10),
              ],
            ),
            CustomBasicContainer(
              width: screenWidth,
              height: 150,
              child: CustomCobotStatusDataTable(
                  cobots: getDeviceCobotController.cobots,
                  devices: getDeviceController.filteredDevices),
            ),
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
                Text('   Navigation',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(width: 350, height: 200),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('   장비 제어',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(
                  width: 350,
                  height: 200,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('작동 모드',
                            style: AppTextStyles.bold.copyWith(fontSize: 17)),
                        SizedBox(height: 10),
                        CustomDeviceControlSwitchButton(),
                      ],
                    ),
                  ),
                ),
                CustomBasicContainer(
                  width: 350,
                  height: 250,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomDefaultControlContainer(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: 'text',
                                    child: VelocityControlPanel(
                                      title: 'Axis 1',
                                    )),
                                SizedBox(width: 10),
                                CustomDefaultControlContainer(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: 'text',
                                    child: VelocityControlPanel(
                                      title: 'Axis 2',
                                    )),
                                SizedBox(width: 10),
                                CustomDefaultControlContainer(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: 'text',
                                    child: VelocityControlPanel(
                                      title: 'Axis 3',
                                    )),
                                SizedBox(width: 10),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CustomBasicContainer(
                  width: 350,
                  height: 250,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomDefaultControlContainer(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: 'text',
                                    child: VelocityControlPanel(
                                      title: 'Axis 4',
                                    )),
                                SizedBox(width: 10),
                                CustomDefaultControlContainer(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: 'text',
                                    child: VelocityControlPanel(
                                      title: 'Axis 5',
                                    )),
                                SizedBox(width: 10),
                                CustomDefaultControlContainer(
                                  width: 85,
                                  height: 220,
                                  color: Colors.white,
                                  text: 'text',
                                  child: VelocityControlPanel(
                                    title: 'Axis 6',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
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
                  height: 150,
                  child: CustomCobotStatusDataTable(
                      cobots: getDeviceCobotController.cobots,
                      devices: getDeviceController.devices),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/conveyor_device/get_device_conveyor_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/get_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/post_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_status_controller.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/button/custom_conveyor_device_control_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_conveyor_data_table.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/smart_rack_status_table.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipmentDeviceConveyorControlScreen extends StatefulWidget {
  EquipmentDeviceConveyorControlScreen({super.key});

  @override
  State<EquipmentDeviceConveyorControlScreen> createState() =>
      _EquipmentDeviceConveyorControlScreenState();
}

class _EquipmentDeviceConveyorControlScreenState
    extends State<EquipmentDeviceConveyorControlScreen> {
  final getDeviceConveyorController = Get.find<GetDeviceConveyorController>();

  final getConveyorController = Get.find<GetDeviceConveyorStatusController>();

  final postDeviceController = Get.find<PostDeviceConveyorStatusController>();

  final List<int> dropdownOptions1 = [
    1,
    2,
    3,
    4,
    5,
  ];

  final List<String> dropdownOptions2 = ['ERROR', 'IDLE', 'RUNNING'];

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDesktop = screenWidth > 1000; // 데스크탑 화면으로 간주하는 기준

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: isDesktop
          ? _buildDesktopLayout(context, screenWidth)
          : _buildMobileLayout(),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth) {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomConveyorDeviceControlButton(
                            width: 400,
                            height: 70,
                            color: Color(0xFF9FDCA6),
                            text: '순방향'),
                        SizedBox(height: 20),
                        CustomConveyorDeviceControlButton(
                            width: 400,
                            height: 70,
                            color: Color(0xFFFF6C6C),
                            text: '정지'),
                        SizedBox(height: 20),
                        CustomConveyorDeviceControlButton(
                            width: 400,
                            height: 70,
                            color: Color(0xFF6CA7FF),
                            text: '역방향')
                      ],
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
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('더블클릭 다이얼로그'),
                            content: Column(
                              children: [
                                buildTextField(
                                  label: 'Name:',
                                  controller:
                                      postDeviceController.nameController,
                                ),
                                buildTextField(
                                  label: 'modelName:',
                                  controller:
                                      postDeviceController.modelNameController,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate:
                                          postDeviceController.equippedAt ??
                                              DateTime.now(),
                                      firstDate: DateTime(2022),
                                      lastDate: DateTime(2025),
                                    );

                                    if (pickedDate != null) {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.fromDateTime(
                                          postDeviceController.equippedAt ??
                                              DateTime.now(),
                                        ),
                                      );

                                      if (pickedTime != null) {
                                        postDeviceController.equippedAt =
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
                                      text: postDeviceController.equippedAt
                                              ?.toString() ??
                                          '',
                                    ),
                                  ),
                                ),
                                buildTextField(
                                  label: 'manufactruer_Name:',
                                  controller: postDeviceController
                                      .manufacturerNameController,
                                ),
                                buildTextField(
                                  label: 'tenant_id:',
                                  controller:
                                      postDeviceController.tenantIdController,
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Mode',
                                    // Add any additional styling or decoration as needed
                                  ),
                                  value: dropdownOptions2.contains(
                                          postDeviceController
                                              .statusController.text)
                                      ? postDeviceController
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
                                      postDeviceController
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
                                          postDeviceController
                                              .speedController.text)
                                      ? postDeviceController
                                          .speedController.text
                                      : null,
                                  items: dropdownOptions1.map((int value) {
                                    return DropdownMenuItem<String>(
                                      value: value.toString(),
                                      child: Text(value.toString()),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      postDeviceController
                                          .speedController.text = newValue;
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    postDeviceController.initializeData();
                                    print(postDeviceController
                                        .speedController.text);
                                    print(postDeviceController
                                        .nameController.text);
                                    print(postDeviceController
                                        .modelNameController.text);
                                    print(postDeviceController.equippedAt);
                                    print(postDeviceController
                                        .tenantIdController.text);
                                    print(postDeviceController
                                        .statusController.text);
                                    print(postDeviceController
                                        .manufacturerNameController.text);
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
              ],
            ),
            CustomBasicContainer(
              width: screenWidth,
              height: 150,
              child: CustomConveyorStatusDataTable(
                  conveyors: getConveyorController.conveyors,
                  devices: getDeviceConveyorController.filteredDevices),
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
                Text('  Navigation',
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
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomConveyorDeviceControlButton(
                          width: 300,
                          height: 50,
                          color: Color(0xFF9FDCA6),
                          text: '순방향'),
                      SizedBox(height: 20),
                      CustomConveyorDeviceControlButton(
                          width: 300,
                          height: 50,
                          color: Color(0xFFFF6C6C),
                          text: '정지'),
                      SizedBox(height: 20),
                      CustomConveyorDeviceControlButton(
                          width: 300,
                          height: 50,
                          color: Color(0xFF6CA7FF),
                          text: '역방향')
                    ],
                  ),
                ),
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
                  height: 350,
                  child: CustomConveyorStatusDataTable(
                      conveyors: getConveyorController.conveyorStatus,
                      devices: getDeviceConveyorController.filteredDevices),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

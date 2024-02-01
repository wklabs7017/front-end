import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/post_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/device/delete_device_status_controller.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_controller.dart';
import 'package:bsn_v2/controller/manufacturer/get_manufacturer_controller.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_button.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_container.dart';
import 'package:bsn_v2/view/widget/button/custom_default_control_mini_button.dart';
import 'package:bsn_v2/view/widget/button/custom_device_switch_button.dart';
import 'package:bsn_v2/view/widget/button/custom_task_button.dart';
import 'package:bsn_v2/view/widget/container/custom_basic_container.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_overview_screen_app_bar.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_agv_data_table.dart';
import 'package:bsn_v2/view/widget/etc/data_table/custom_overview_smart_rack_data_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_device_status_table.dart';
import 'package:bsn_v2/view/widget/etc/custom_velocity_control_pannel.dart';
import 'package:bsn_v2/view/widget/etc/smart_rack_status_table.dart';
import 'package:bsn_v2/view/widget/etc/user_management_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EquipmentDeviceAgvControlScreen extends StatefulWidget {
  EquipmentDeviceAgvControlScreen({super.key});

  @override
  State<EquipmentDeviceAgvControlScreen> createState() =>
      _EquipmentDeviceAgvControlScreenState();
}

class _EquipmentDeviceAgvControlScreenState
    extends State<EquipmentDeviceAgvControlScreen> {
  // GetX 컨트롤러들을 여기에 선언합니다.
  late DeleteDeviceStautsController deleteDeviceController;
  late GetDeviceAgvStatusController getDeviceAgvController;
  late GetDeviceAGVController getDeviceController;
  late PatchDeviceAgvBatteryLevelController
      patchDeviceAgvBatteryLevelController;
  late PatchDeviceAgvDriveDistanceController
      patchDeviceAgvDriveDistanceController;
  late PatchDeviceAgvModeController patchDeviceAgvModeController;
  late PostDeviceAgvStatusController postDeviceAgvStatusController;

  final getManufacturerController = Get.find<GetManufacturerController>();
  final postDeviceAgvController = Get.find<PostDeviceAgvStatusController>();

  late List<String> dropdownOptions3;

  final List<String> dropdownOptions1 = ['AUTO', 'MANUAL'];

  final List<String> dropdownOptions2 = ['ERROR', 'IDLE', 'RUNNING'];
  @override
  void initState() {
    super.initState();

    // initState에서 GetX 컨트롤러들을 초기화합니다.
    deleteDeviceController = Get.find<DeleteDeviceStautsController>();
    getDeviceAgvController = Get.find<GetDeviceAgvStatusController>();
    getDeviceController = Get.find<GetDeviceAGVController>();
    patchDeviceAgvBatteryLevelController =
        Get.find<PatchDeviceAgvBatteryLevelController>();
    patchDeviceAgvDriveDistanceController =
        Get.find<PatchDeviceAgvDriveDistanceController>();
    patchDeviceAgvModeController = Get.find<PatchDeviceAgvModeController>();
    postDeviceAgvStatusController = Get.find<PostDeviceAgvStatusController>();

    // 페이지로 돌아갈 때마다 컨트롤러를 다시 초기화합니다.
    dropdownOptions3 = getManufacturerController.manufacturerDetail
        .map((manufacturer) => manufacturer.name)
        .toList();
  }

  // 함수 추가: 제조사 선택 다이얼로그
  Future<void> _showManufacturerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Manufacturer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: dropdownOptions3.map((String value) {
                return ListTile(
                  title: Text(value),
                  onTap: () {
                    Navigator.of(context).pop(value);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
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
                  CustomBasicContainer(
                    width: screenWidth * 0.3,
                    height: 400,
                    child: TextButton(
                        onPressed: () {
                          getDeviceAgvController.initializeData();
                          getDeviceController.initializeData();
                          print(getDeviceAgvController.agvs);
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
                              style: AppTextStyles.bold.copyWith(fontSize: 17)),
                          SizedBox(height: 10),
                          CustomDeviceControlSwitchButton(),
                          SizedBox(height: 50),
                          Container(
                            width: 300.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomDefaultControlButton(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: '좌회전'),
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
                                          text: '전진'),
                                      SizedBox(height: 5),
                                      CustomDefaultControlMiniButton(
                                          width: 104,
                                          height: 49,
                                          color: Colors.white,
                                          text: '중지'),
                                      SizedBox(height: 5),
                                      CustomDefaultControlMiniButton(
                                          width: 104,
                                          height: 49,
                                          color: Colors.white,
                                          text: '후진')
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                CustomDefaultControlButton(
                                    width: 85,
                                    height: 220,
                                    color: Colors.white,
                                    text: '우회전'),
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
                                  ),
                                ),
                              ],
                            ),
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
                                      postDeviceAgvController.nameController,
                                ),
                                buildTextField(
                                  label: 'Model Name:',
                                  controller: postDeviceAgvController
                                      .modelNameController,
                                ),
                                buildTextField(
                                  label: 'Manufacturer:',
                                  controller: postDeviceAgvController
                                      .manufacturerNameController,
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Mode',
                                    // Add any additional styling or decoration as needed
                                  ),
                                  value: dropdownOptions3.contains(
                                          postDeviceAgvController
                                              .manufacturerNameController.text)
                                      ? postDeviceAgvController
                                          .manufacturerNameController.text
                                      : null,
                                  items: dropdownOptions3.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      postDeviceAgvController
                                          .manufacturerNameController
                                          .text = newValue;
                                    }
                                  },
                                ),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Select Mode',
                                    // Add any additional styling or decoration as needed
                                  ),
                                  value: dropdownOptions2.contains(
                                          postDeviceAgvController
                                              .statusController.text)
                                      ? postDeviceAgvController
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
                                      postDeviceAgvController
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
                                          postDeviceAgvController
                                              .modeController.text)
                                      ? postDeviceAgvController
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
                                      postDeviceAgvController
                                          .modeController.text = newValue;
                                    }
                                  },
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    postDeviceAgvController.initializeData();
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
                height: 200.h,
                child: CustomAgvStatusDataTable(
                    agvs: getDeviceAgvController.agvs,
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
                Text('   Navigation',
                    style: AppTextStyles.bold
                        .copyWith(color: Colors.black, fontSize: 25)),
                CustomBasicContainer(
                  width: 350,
                  height: 200,
                  child: Container(),
                ),
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
                  height: 150,
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
              ],
            ),
            CustomBasicContainer(
              width: 350,
              height: 200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDefaultControlButton(
                      width: 60, height: 180, color: Colors.white, text: '좌회전'),
                  SizedBox(width: 5),
                  CustomDefaultControlContainer(
                    width: 90,
                    height: 180,
                    color: Colors.white,
                    text: 'text',
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomDefaultControlMiniButton(
                            width: 80,
                            height: 45,
                            color: Colors.white,
                            text: '전진'),
                        SizedBox(height: 5),
                        CustomDefaultControlMiniButton(
                            width: 80,
                            height: 45,
                            color: Colors.white,
                            text: '중지'),
                        SizedBox(height: 5),
                        CustomDefaultControlMiniButton(
                            width: 80,
                            height: 45,
                            color: Colors.white,
                            text: '후진')
                      ],
                    ),
                  ),
                  SizedBox(width: 5),
                  CustomDefaultControlButton(
                      width: 60, height: 180, color: Colors.white, text: '우회전'),
                ],
              ),
            ),
            CustomBasicContainer(
              width: 350,
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomDefaultControlContainer(
                      width: 60,
                      height: 180,
                      color: Colors.white,
                      text: 'text',
                      child: VelocityControlPanel(
                        title: '선속도',
                      )),
                  SizedBox(width: 20),
                  CustomDefaultControlContainer(
                    width: 60,
                    height: 180,
                    color: Colors.white,
                    text: 'text',
                    child: VelocityControlPanel(
                      title: '각속도',
                    ),
                  ),
                ],
              ),
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
                        width: 150,
                        height: 25,
                        onTap: () {},
                        text: '장비 추가',
                        color: AppColors.primaryColor),
                    SizedBox(width: 5),
                    CustomMiniTaskButton(
                        width: 150,
                        height: 25,
                        onTap: () {},
                        text: '장비 추가',
                        color: AppColors.primaryColor),
                    SizedBox(width: 5),
                  ],
                ),
                CustomBasicContainer(
                  width: 350,
                  height: 200,
                  child: CustomAgvStatusDataTable(
                      agvs: getDeviceAgvController.agvs,
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

import 'dart:io';

import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_pages.dart';
import 'package:bsn_v2/controller/auth/account_reset_controller.dart';
import 'package:bsn_v2/controller/auth/sign_in_controller.dart';
import 'package:bsn_v2/controller/auth/sign_up_controller.dart';
import 'package:bsn_v2/controller/console_log/get_console_log.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/post_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/patch_device_cobot_mode_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/patch_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/post_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/get_device_conveyor_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/get_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/patch_device_conveyor_speed_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/patch_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/post_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/device/delete_device_status_controller.dart';
import 'package:bsn_v2/controller/device/device/get_device_status_controller.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_.dart';
import 'package:bsn_v2/controller/device/smart_rack_device/smart_rack/get_device_smart_rack_status_controller.dart';
import 'package:bsn_v2/controller/index/setting/setting_controller.dart';
import 'package:bsn_v2/controller/manufacturer/get_manufacturer_controller.dart';
import 'package:bsn_v2/controller/manufacturer/post_manufacturer_controller.dart';
import 'package:bsn_v2/controller/task/devices/get_task_devices_status_controller.dart';
import 'package:bsn_v2/controller/task/get_task_status_controller.dart';
import 'package:bsn_v2/controller/tenant/get_tenant_controller.dart';
import 'package:bsn_v2/controller/tenant/post_tenant_controller.dart';
import 'package:bsn_v2/controller/user/get_user_info_controller.dart';
import 'package:bsn_v2/controller/user/get_user_info_list_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_email_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_password_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_privilege_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_tenant_controller.dart';
import 'package:bsn_v2/controller/user/patch_user_user_id_controller.dart';
import 'package:bsn_v2/controller/work/get_work_log_controller.dart';
import 'package:bsn_v2/view/screens/auth_screen/account_reset_screen.dart';

import 'package:bsn_v2/view/screens/auth_screen/sign_in_screen.dart';
import 'dart:io'; // Platform 클래스 사용을 위해 필요
import 'package:flutter/foundation.dart' show kIsWeb; // kIsWeb을 사용하기 위해 필요
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart'
    as window_size; // 윈도우 크기를 설정하기 위해 추가

import 'package:bsn_v2/view/screens/index_screen/task_management_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_size/window_size.dart' as window_size;
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(345, 700), // 여기에 기준이 되는 디자인 크기를 입력합니다.
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(
            useMaterial3: false,
            dialogBackgroundColor:
                AppColors.backgroundColor, // 다이얼로그 배경색을 흰색으로 설정
            // 기타 테마 관련 설정
          ),
          debugShowCheckedModeBanner: false,
          initialBinding: BindingsBuilder(
            () {
              Get.put(SignUpController());
              Get.put(SignInController());
              Get.put(AccountResetController());
              Get.lazyPut(() => PatchUserPrevillegeController());
              Get.lazyPut(() => PatchUserTenantController());

              //Overview
              Get.put(GetConsoleLogStautsController());
              Get.put(GetDeviceStautsController());
              //Tenant
              Get.put(GetTenantDetailController());

              Get.lazyPut(() => PostTenantDetailController());
              //Manufacturer
              Get.put(GetManufacturerController());
              Get.lazyPut(() => PostManufacturerController());
              //Task
              Get.lazyPut(() => GetDeviceTaskController());

              //device
              Get.lazyPut(() => DeleteDeviceStautsController());

              //AGV
              Get.put(GetDeviceAgvStatusController());
              Get.put(GetDeviceAGVController());

              Get.lazyPut(() => PatchDeviceAgvBatteryLevelController());
              Get.lazyPut(() => PatchDeviceAgvDriveDistanceController());
              Get.lazyPut(() => PatchDeviceAgvModeController());
              Get.put(PatchDeviceAgvStatusController());
              Get.lazyPut(() => PostDeviceAgvStatusController());
              //cobot
              Get.put(GetDeviceCobotStatusController());
              Get.put(GetDeviceCobotController());

              Get.lazyPut(() => PatchDeviceCobotModeController());
              Get.lazyPut(() => PatchDeviceCobotStatusController());
              Get.lazyPut(() => PostDeviceCobotStatusController());
              //Conveyor
              Get.put(GetDeviceConveyorController());

              Get.put(GetDeviceConveyorStatusController());
              Get.lazyPut(() => PatchDeviceConveyorSpeedController());
              Get.lazyPut(() => PatchDeviceConveyorStatusController());
              Get.lazyPut(() => PostDeviceConveyorStatusController());
              //Smart_rack
              Get.put(GetDeviceSmartRackController());
              Get.put(GetDeviceSmartRackController());
              Get.lazyPut(() => GetDeviceSmartRakckStatusController());

              //Setting
              Get.lazyPut(() => SettingController());
              Get.lazyPut(() => GetUserInfoController());
              Get.lazyPut(() => GetUserInfoListController());
              Get.lazyPut(() => PatchUserIDController());
              Get.lazyPut(() => PatchUserEmailController());
              Get.lazyPut(() => PatchUserPasswordController());
            },
          ),
          getPages: AppPages.routes, // GetX 라우트 사용
          //initialRoute: '/login', // 초기 라우트 지정 (예: '/login')

          home: SignInScreen(),
          // 다른 필요한 속성들...
        );
      },
    );
  }
}

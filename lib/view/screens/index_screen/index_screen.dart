import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/navigation_controller.dart';
import 'package:bsn_v2/controller/user/get_user_info_controller.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_control_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_control_screen/equipment_device_agv_control_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_control_screen/equipment_device_cobot_control_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_control_screen/equipment_device_conveyor_control_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_control_screen/equipment_device_smart_rack_control_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_management_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/overview_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/post_tenant_detail_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/setting_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/task_management_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/tenant_screen.dart';
import 'package:bsn_v2/view/widget/app_bar/custom_basic_app_bar.dart';
import 'package:bsn_v2/view/widget/button/custom_menu_button.dart';
import 'package:bsn_v2/view/widget/custom_expasin_tile.dart';
import 'package:bsn_v2/view/widget/etc/custom_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _selectedIndex = 0;
  int _selectedParentIndex = -1; // 부모 메뉴의 선택 인덱스 추가

  final navigationController = Get.put(NavigationController());
  final getUserInfoController = Get.find<GetUserInfoController>();

  final List<Widget> pages = [
    OverviewScreen(),
    EquipmentDeviceAgvControlScreen(),
    EquipmentDeviceCobotControlScreen(),
    EquipmentDeviceConveyorControlScreen(),
    EquipmentDeviceSmartRackControlScreen(),
    TaskManagementScreen(),
    SettingScreen(),
    TenantScreen(),
  ];

  void _onSelectItem(int index, {int parentIndex = -1}) {
    Navigator.of(context).pop(); // 드로어 닫기
    setState(() {
      _selectedIndex = index;
      _selectedParentIndex = parentIndex; // 부모 메뉴 인덱스 업데이트
    });
  }

  // 각 인덱스에 해당하는 페이지 제목
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return '개요';
      case 1:
        return '장비 제어';
      case 2:
        return '장비 관리';
      case 3:
        return '작업 관리';
      case 4:
        return '설정';
      default:
        return 'BSN V2';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: CustomBasicAppBar(text: _getTitle(_selectedIndex)),
      drawer: Container(
        width: 300,
        decoration: BoxDecoration(color: AppColors.primaryColor),
        child: Drawer(
          backgroundColor: AppColors.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomProfile(),
              MenuButton(
                iconData: Icons.bar_chart,
                title: '개요',
                onTap: () => _onSelectItem(0, parentIndex: 0),
                isSelected: _selectedIndex == 0,
              ),

              CustomExpansionTile(
                title: '장비 관리',
                color:
                    _selectedParentIndex == 1 ? AppColors.primaryColor : null,
                children: [
                  MenuButton(
                    iconData: Icons.directions_car,
                    title: 'AGV',
                    onTap: () => _onSelectItem(1, parentIndex: 1),
                    isSelected: _selectedIndex == 1,
                  ),
                  MenuButton(
                    iconData: Icons.build_circle,
                    title: '협동로봇',
                    onTap: () => _onSelectItem(2, parentIndex: 1),
                    isSelected: _selectedIndex == 2,
                  ),
                  MenuButton(
                    iconData: Icons.loop,
                    title: '컨베이어',
                    onTap: () => _onSelectItem(3, parentIndex: 1),
                    isSelected: _selectedIndex == 3,
                  ),
                  MenuButton(
                    iconData: Icons.storage,
                    title: '스마트랙',
                    onTap: () => _onSelectItem(4, parentIndex: 1),
                    isSelected: _selectedIndex == 4,
                  ),
                ],
              ),

              MenuButton(
                iconData: Icons.assignment,
                title: '작업 관리',
                onTap: () => _onSelectItem(
                  5,
                ),
                isSelected: _selectedIndex == 5,
              ),

              CustomExpansionTile(
                title: '환경 설정',
                color:
                    _selectedParentIndex == 1 ? AppColors.primaryColor : null,
                children: [
                  MenuButton(
                    iconData: Icons.bar_chart,
                    title: '계정 설정',
                    onTap: () => _onSelectItem(6, parentIndex: 3),
                    isSelected: _selectedIndex == 6,
                  ),
                  MenuButton(
                    iconData: Icons.settings,
                    title: '기타 설정',
                    onTap: () => _onSelectItem(7),
                    isSelected: _selectedIndex == 7,
                  ),
                ],
              ),
              Spacer(), // 이 부분이 중요합니다.
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Version 2.0.1',
                    style: AppTextStyles.medium.copyWith(fontSize: 15)),
              ),
            ],
          ),
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}

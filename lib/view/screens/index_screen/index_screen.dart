import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/view/screens/data_table/test.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_control_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/equipment_management_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/overview_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/setting_screen.dart';
import 'package:bsn_v2/view/screens/index_screen/task_management_screen.dart';
import 'package:bsn_v2/view/widget/button/custom_menu_button.dart';
import 'package:bsn_v2/view/widget/etc/custom_profile.dart';
import 'package:flutter/material.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  static const String route = '/index';

  int _selectedIndex = 0; // 현재 선택된 인덱스

  // 각 인덱스에 해당하는 위젯 리스트
  final List<Widget> pages = [
    OverviewScreen(),
    EquipmentControlScreen(),
    EquipmentManagementScreen(),
    TaskManagementScreen(),
    SettingScreen()
    // 여기에 더 많은 페이지를 추가할 수 있습니다.
  ];

  void _onSelectItem(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스 업데이트
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            width: 200, // Drawer의 너비
            child: ListView(
              children: <Widget>[
                CustomProfile(),
                MenuButton(
                    title: '개요',
                    index: 0,
                    onTap: (index) {
                      _onSelectItem(index);
                    },
                    isSelected: _selectedIndex == 0),
                MenuButton(
                    title: '장비 제어',
                    index: 1,
                    onTap: (index) {
                      _onSelectItem(index);
                    },
                    isSelected: _selectedIndex == 1),
                MenuButton(
                    title: '장비 관리',
                    index: 2,
                    onTap: (index) {
                      _onSelectItem(index);
                    },
                    isSelected: _selectedIndex == 2),
                MenuButton(
                    title: '작업 관리',
                    index: 3,
                    onTap: (index) {
                      _onSelectItem(index);
                    },
                    isSelected: _selectedIndex == 3),
                MenuButton(
                    title: '설정',
                    index: 4,
                    onTap: (index) {
                      _onSelectItem(index);
                    },
                    isSelected: _selectedIndex == 4),
              ],
            ),
          ),
          Expanded(
            child: pages[_selectedIndex], // 현재 선택된 페이지
          ),
        ],
      ),
    );
  }
}

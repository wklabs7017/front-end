import 'dart:math';

import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/device/delete_device_status_controller.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/view/widget/etc/data_table/AGV/customAGVmodeDropDownBox456.dart';
import 'package:bsn_v2/view/widget/etc/data_table/AGV/customAGVstatusDropDownBox456.dart.dart.';

import 'package:bsn_v2/view/widget/etc/custom_tenant_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 나머지 import 문들...
class CustomAgvStatusDataTable extends StatefulWidget {
  int? selectedRowIndex;

  CustomAgvStatusDataTable({super.key});

  @override
  _CustomAgvStatusDataTableState createState() =>
      _CustomAgvStatusDataTableState();
}

class _CustomAgvStatusDataTableState extends State<CustomAgvStatusDataTable> {
  int? selectedRowIndex; // 추가: 선택된 행의 인덱스를 저장하는 변수
  DateTime? lastTap;

  Set<int> selectedRows = Set<int>();
  final deleteDeviceController = Get.find<DeleteDeviceStautsController>();
  final getDeviceAgvController = Get.find<GetDeviceAgvStatusController>();
  final getDeviceController = Get.find<GetDeviceAGVController>();

  var patchAgvBatterLevelController =
      Get.find<PatchDeviceAgvBatteryLevelController>();
  var patchAgvDriveDistancController =
      Get.find<PatchDeviceAgvDriveDistanceController>();
  var patchAgvModeController = Get.find<PatchDeviceAgvModeController>();
  var patchAgvStatusController = Get.find<PatchDeviceAgvStatusController>();

  void tryUpdateUserId(int deviceId) async {
    bool success = await patchAgvModeController.initializeData(deviceId);

    final devices = getDeviceController.filteredDevices;

    if (success) {
      patchAgvModeController.update();

      setState(() {
        // 컨트롤러의 이름 정보를 업데이트합니다.
        getDeviceAgvController.agvs[devices[deviceId].id].mode =
            patchAgvModeController.modeController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('수정이 성공적으로 완료되었습니다'),
          duration: Duration(seconds: 2),
        ),
      );
      getDeviceAgvController.update();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('수정이 실패했습니다'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final agvs = getDeviceAgvController.agvs;
      final devices = getDeviceController.filteredDevices;

      return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(
              color: Colors.transparent,
              width: 1, // 두께를 30에서 1로 조정하여 더 적절한 시각적 표현을 제공
            ),
            children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.blue, width: 2)),
                    ),
                    children: [
                      paddedCell('No.', 9, Colors.blue, 0),
                      paddedCell('장비 이름', 9, Colors.blue, 1),
                      paddedCell('연결 상태', 9, Colors.blue, 2),
                      paddedCell('작동 모드', 9, Colors.blue, 3),
                      paddedCell('현재 상태', 9, Colors.blue, 4),
                      paddedCell('총 주행거리', 9, Colors.blue, 5),
                      paddedCell('배터리 잔량', 9, Colors.blue, 6),
                      paddedCell('마지막 연결 시간', 9, Colors.blue, 7),
                      paddedCell('활동 기록', 9, Colors.blue, 8),
                      paddedCell('정비 기록', 9, Colors.blue, 9),
                    ],
                  ),
                ] +
                _generateRows(
                  agvs,
                  devices,
                ),
          ));
    });
  }

  // _generateRows 함수 수정
  List<TableRow> _generateRows(
    List<AGV> agvs,
    List<Device> devices,
  ) {
    List<TableRow> rows = [];
    int loopCount = min(agvs.length, devices.length);

    for (int i = 0; i < loopCount; i++) {
      Color rowColor = selectedRows.contains(i)
          ? Colors.lightBlueAccent
          : Colors.transparent;

      rows.add(TableRow(
        decoration: BoxDecoration(color: rowColor),
        children: <Widget>[
          paddedCell(devices[i].id.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(devices[i].name, 12, Colors.black, i), // 인덱스 전달
          paddedCell(devices[i].modelName, 12, Colors.black, i), // 인덱스 전달
          paddedCell(agvs[i].mode, 12, Colors.black, i), // 인덱스 전달
          paddedCell(agvs[i].status, 12, Colors.black, i), // 인덱스 전달
          paddedCell(
              agvs[i].driveDistance.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(
              agvs[i].batteryLevel.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(
              devices[i].equippedAt.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(
              devices[i].tenantId.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(devices[i].type, 12, Colors.black, i), // 인덱스 전달
        ],
      ));
    }
    return rows;
  }

// paddedCell 함수 수정
  Widget paddedCell(String text, double fontSize, Color color, int index) {
    return GestureDetector(
      onTap: () {
        // 여기에서 _onRowTap 함수를 호출하고, 현재 셀의 인덱스를 전달합니다.
        _onRowTap(index);
      },
      child: Padding(
        padding: EdgeInsets.all(3.0),
        child: Center(
          child: Text(text,
              style: AppTextStyles.bold
                  .copyWith(fontSize: fontSize, color: color)),
        ),
      ),
    );
  }

  TableRow tableRowWithPadding({
    required String id,
    required String name,
    String? connectionStatus,
    String? operationStatus,
    String? lastConnection,
    String? operationStatus2,
    String? lastConnection2,
    String? lastConnection3,
    Widget? actionButton,
    Widget? actionButton2,
  }) {
    // 모든 셀에 대해 값을 제공하지 않은 경우를 대비하여 기본값 설정
    connectionStatus ??= '-';
    operationStatus ??= '-';
    lastConnection ??= '-';
    operationStatus2 ??= '-';
    lastConnection2 ??= '-';
    lastConnection3 ??= '-';
    actionButton ??= TextButton(onPressed: () {}, child: Text('N/A'));
    actionButton2 ??= SizedBox.shrink(); // 기본값으로 빈 위젯을 설정

    return TableRow(
      children: [
        paddedCell(id, 12, Colors.black, 0),
        paddedCell(name, 12, Colors.black, 1),
        paddedCell(connectionStatus, 12, Colors.black, 2),
        paddedCell(operationStatus, 12, Colors.black, 3),
        paddedCell(lastConnection, 12, Colors.black, 4),
        paddedCell(operationStatus2, 12, Colors.black, 5),
        paddedCell(lastConnection2, 12, Colors.black, 6),
        paddedCell(lastConnection3, 12, Colors.black, 7), // 새로운 매개변수 사용
        paddedCell(lastConnection, 12, Colors.black, 8), // 새로운 매개변수 사용
        paddedCell(lastConnection3, 12, Colors.black, 9), // 새로운 매개변수 사용

        Padding(
          padding: EdgeInsets.all(3.0),
          child: actionButton, // 첫 번째 액션 버튼
        ),
        Padding(
          padding: EdgeInsets.all(3.0),
          child: actionButton2, // 두 번째 액션 버튼
        ),
      ],
    );
  }

  void _onRowTap(int index) {
    final agvs = getDeviceAgvController.agvs;
    final devices = getDeviceController.filteredDevices;

    final DateTime now = DateTime.now();
    if (lastTap == null ||
        now.difference(lastTap!) > Duration(milliseconds: 300)) {
      // 첫 클릭 또는 더블 클릭이 아닌 경우
      setState(() {
        // 선택된 행 초기화 후 현재 클릭한 행만 선택
        patchAgvModeController.modeController.text = agvs[index].mode;

        selectedRows = {index};
      });
      lastTap = now;
    } else {
      // 더블 클릭인 경우
      setState(() {
        // 선택된 행 초기화 후 현재 클릭한 행만 선택
        selectedRows = {index};

        // 여기에 다이얼로그를 띄우는 코드 추가
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                width: 700,
                height: 440,
                child: AlertDialog(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Column(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.close))
                        ],
                      ),
                      Text(
                        'AGV 기본 정보 수정',
                        style: AppTextStyles.bold
                            .copyWith(color: Color(0xFF232323)),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '해당 란을 수정하기 위해선 더블 클릭 해주세요.',
                        style: AppTextStyles.bold
                            .copyWith(fontSize: 12, color: Colors.red),
                      ),
                    ],
                  ),
                  content: Column(
                    children: [
                      CustomAGVModeDropDownBox456(
                        label: '현재 모드',
                        text: '${getDeviceAgvController.agvs[index].mode}',
                      ),
                      SizedBox(height: 5),
                      CustomAGVStatusDropDownBox456(
                        label: '현재 상태',
                        text: '${getDeviceAgvController.agvs[index].status}',
                      ),
                      SizedBox(height: 5),
                      CustomTenantListTileDetail(
                        label: '배터리 잔량',
                        text:
                            '${getDeviceAgvController.agvs[index].batteryLevel}',
                        controller: patchAgvBatterLevelController
                            .batteryLevelController,
                      ),
                      SizedBox(height: 5),
                      CustomTenantListTileDetail(
                        label: '총 주행거리',
                        text:
                            '${getDeviceAgvController.agvs[index].driveDistance}',
                        controller: patchAgvDriveDistancController
                            .driveDistanceController,
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              minimumSize: Size(120, 45),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('수정완료'),
                            onPressed: () async {
                              Navigator.pop(context); // 다이얼로그 닫기

                              await patchAgvModeController
                                  .initializeData(devices[index].id);
                              await patchAgvStatusController
                                  .initializeData(devices[index].id);
                              await patchAgvDriveDistancController
                                  .initializeData(devices[index].id);
                              await patchAgvBatterLevelController
                                  .initializeData(devices[index].id);
                              selectedRowIndex = null;

                              // 데이터 다시 불러오기
                              await getDeviceAgvController.initializeData();
                              await getDeviceController.initializeData();

                              selectedRows.clear();
                              // setState(() {});
                            },
                          ),
                          SizedBox(width: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              minimumSize: Size(120, 45),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text('삭제하기'),
                            onPressed: () {
                              deleteDeviceController
                                  .initializeData(devices[index].id);
                              // 선택된 행 삭제
                              agvs.removeAt(index);
                              devices.removeAt(index);

                              // 선택된 행 초기화
                              selectedRowIndex = null;
                              selectedRows.clear();
                              print(index);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
    }
  }

  void _editSelectedRow() {
    // 추가: 수정 버튼 눌렀을 때 호출되는 함수
    if (selectedRowIndex != null) {
      // 선택된 행에 대한 수정 로직 구현
    }
  }

  void _deleteSelectedRow(int index) {
    final agvs = getDeviceAgvController.agvs;
    final devices = getDeviceController.filteredDevices;

    // 선택된 행에 대한 삭제 로직 구현
    if (selectedRowIndex != null) {
      setState(() {
        // 삭제 전에 초기화
        deleteDeviceController.initializeData(devices[index].id);

        print('야야${index}');

        // 선택된 행 삭제
        agvs.removeAt(index);
        devices.removeAt(index);

        // 선택된 행 초기화
        selectedRowIndex = null;
        selectedRows.clear();
      });
    }
  }
}

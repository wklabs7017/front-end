import 'dart:math';

import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/patch_device_cobot_mode_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/patch_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/patch_device_conveyor_speed_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/patch_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/device/delete_device_status_controller.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/cobot.dart';
import 'package:bsn_v2/model/converyor.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/etc/data_table/cobot/customCobotmodeDropDownBox456.dart';
import 'package:bsn_v2/view/widget/etc/data_table/cobot/customCobotstatusDropDownBox456.dart';

import 'package:bsn_v2/view/widget/text_field/custom_deivce_detail_correction_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 나머지 import 문들...
class CustomCobotStatusDataTable extends StatefulWidget {
  // final RxList<Cobot> cobots;
  // final RxList<Device> devices;

  int? selectedRowIndex;

  CustomCobotStatusDataTable({super.key});
  // CustomCobotStatusDataTable({
  //   required this.cobots,
  //   required this.devices,
  // });

  @override
  _CustomCobotStatusDataTableState createState() =>
      _CustomCobotStatusDataTableState();
}

class _CustomCobotStatusDataTableState
    extends State<CustomCobotStatusDataTable> {
  int? selectedRowIndex; // 추가: 선택된 행의 인덱스를 저장하는 변수
  DateTime? lastTap;

  Set<int> selectedRows = Set<int>();
  final deleteDeviceController = Get.find<DeleteDeviceStautsController>();
  //
  var getCobotStatusController = Get.find<GetDeviceCobotStatusController>();
  var patchCobotModeController = Get.find<PatchDeviceCobotModeController>();

  var patchCobotStatusController = Get.find<PatchDeviceCobotStatusController>();

  final getDeviceController = Get.find<GetDeviceCobotController>();

  final getDeviceCobotController = Get.find<GetDeviceCobotStatusController>();

  void tryUpdateUserId(int deviceId) async {
    bool success = await patchCobotModeController.initializeData(deviceId);

    final devices = getDeviceController.filteredDevices;

    if (success) {
      patchCobotModeController.update();

      setState(() {
        // 컨트롤러의 이름 정보를 업데이트합니다.
        getDeviceCobotController.cobots[devices[deviceId].id].mode =
            patchCobotModeController.modeController.text;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('수정이 성공적으로 완료되었습니다'),
          duration: Duration(seconds: 2),
        ),
      );
      getDeviceCobotController.update();
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
      final cobots = getDeviceCobotController.cobots;
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
                      paddedCell('현재 상태', 9, Colors.blue, 4),
                      paddedCell('현재 속도', 9, Colors.blue, 5),
                      paddedCell('마지막 연결 시간', 9, Colors.blue, 7),
                      paddedCell('활동 기록', 9, Colors.blue, 8),
                      paddedCell('정비 기록', 9, Colors.blue, 9),
                    ],
                  ),
                ] +
                _generateRows(
                  cobots,
                  devices,
                ),
          ));
    });
  }

  // _generateRows 함수 수정
  List<TableRow> _generateRows(
    List<Cobot> cobots,
    List<Device> devices,
  ) {
    List<TableRow> rows = [];
    int loopCount = min(cobots.length, devices.length);

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
          paddedCell(cobots[i].status, 12, Colors.black, i), // 인덱스 전달

          paddedCell(cobots[i].mode, 12, Colors.black, i), // 인덱스 전달
          paddedCell(cobots[i].mode, 12, Colors.black, i), // 인덱스 전달

          paddedCell(
              devices[i].equippedAt.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(
              devices[i].tenantId.toString(), 12, Colors.black, i), // 인덱스 전달
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
    final cobots = getDeviceCobotController.cobots;
    final devices = getDeviceController.filteredDevices;

    final DateTime now = DateTime.now();
    if (lastTap == null ||
        now.difference(lastTap!) > Duration(milliseconds: 300)) {
      // 첫 클릭 또는 더블 클릭이 아닌 경우
      setState(() {
        // 선택된 행 초기화 후 현재 클릭한 행만 선택
        patchCobotModeController.modeController.text = cobots[index].mode;

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
                      CustomCobotModeDropDownBox456(
                        label: '모드',
                        text: '${getCobotStatusController.cobots[index].mode}',
                      ),
                      SizedBox(height: 5),
                      CustomCobotStatusDropDownBox456(
                        label: '상태',
                        text:
                            '${getCobotStatusController.cobots[index].status}',
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
                              await patchCobotModeController
                                  .initializeData(devices[index].id);
                              await patchCobotStatusController
                                  .initializeData(devices[index].id);
                              await getDeviceCobotController.initializeData();
                              await getDeviceController.initializeData();
                              selectedRowIndex = null;

                              selectedRows.clear();
                              Navigator.pop(context); // 다이얼로그 닫기
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
                              cobots.removeAt(index);
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
    final cobots = getDeviceCobotController.cobots;
    final devices = getDeviceController.filteredDevices;

    // 선택된 행에 대한 삭제 로직 구현
    // 선택된 행에 대한 삭제 로직 구현
    if (selectedRowIndex != null) {
      setState(() {
        // 삭제 전에 초기화
        //deleteDeviceController.initializeData(widget.devices[index].id);

        print('야야${index}');

        // 선택된 행 삭제
        cobots.removeAt(index);
        devices.removeAt(index);

        // 선택된 행 초기화
        selectedRowIndex = null;
        selectedRows.clear();
      });
    }
  }
}

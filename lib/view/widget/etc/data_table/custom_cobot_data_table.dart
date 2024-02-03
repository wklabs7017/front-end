import 'dart:math';

import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_battery_level_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_drive_distance_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/patch_device_conveyor_speed_controller.dart';
import 'package:bsn_v2/controller/device/conveyor_device/patch_device_conveyor_status_controller.dart';
import 'package:bsn_v2/controller/device/device/delete_device_status_controller.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/cobot.dart';
import 'package:bsn_v2/model/converyor.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:bsn_v2/view/widget/text_field/custom_deivce_detail_correction_text_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 나머지 import 문들...
class CustomCobotStatusDataTable extends StatefulWidget {
  final RxList<Cobot> cobots;
  final RxList<Device> devices;

  int? selectedRowIndex;

  // 선택된 행을 추적하기 위한 Set 추가
  CustomCobotStatusDataTable({
    required this.cobots,
    required this.devices,
  });

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
  // var patchConveyorSpeedController =
  //     Get.find<PatchDeviceConveyorSpeedController>();
  // var patchConveyorStatusController =
  //     Get.find<PatchDeviceConveyorStatusController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
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
              _generateRows(),
        )));
  }

  // _generateRows 함수 수정
  List<TableRow> _generateRows() {
    List<TableRow> rows = [];
    int loopCount = min(widget.cobots.length, widget.devices.length);

    for (int i = 0; i < loopCount; i++) {
      Color rowColor = selectedRows.contains(i)
          ? Colors.lightBlueAccent
          : Colors.transparent;

      rows.add(TableRow(
        decoration: BoxDecoration(color: rowColor),
        children: <Widget>[
          paddedCell(
              widget.devices[i].id.toString(), 12, Colors.black, i), // 인덱스 전달
          paddedCell(widget.devices[i].name, 12, Colors.black, i), // 인덱스 전달
          paddedCell(
              widget.devices[i].modelName, 12, Colors.black, i), // 인덱스 전달
          paddedCell(widget.cobots[i].status, 12, Colors.black, i), // 인덱스 전달

          paddedCell(widget.cobots[i].mode, 12, Colors.black, i), // 인덱스 전달
          paddedCell(widget.cobots[i].mode, 12, Colors.black, i), // 인덱스 전달

          paddedCell(widget.devices[i].equippedAt.toString(), 12, Colors.black,
              i), // 인덱스 전달
          paddedCell(widget.devices[i].tenantId.toString(), 12, Colors.black,
              i), // 인덱스 전달
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
    final DateTime now = DateTime.now();
    if (lastTap == null ||
        now.difference(lastTap!) > Duration(milliseconds: 300)) {
      // 첫 클릭 또는 더블 클릭이 아닌 경우
      setState(() {
        // 선택된 행 초기화 후 현재 클릭한 행만 선택

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
            return AlertDialog(
              title: Text('더블클릭 다이얼로그'),
              content: Column(
                children: [
                  Row(
                    children: [
                      Text('장비 ID: ${widget.devices[index].id}'),
                      Text('장비 이름: ${widget.devices[index].name}'),
                    ],
                  ),
                  // CustomDeviceDetailCorrectiontextField(
                  //   controller: patchConveyorStatusController.statusController,
                  //   maxLength: 20,
                  //   labelText: '현재 상태',
                  // ),
                  // CustomDeviceDetailCorrectiontextField(
                  //   controller: patchConveyorSpeedController.speedController,
                  //   maxLength: 20,
                  //   labelText: '현재 속도',
                  // ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // 수정 확인 버튼을 눌렀을 때 호출되는 함수
                    //patchAgvModeController
                    //    .initializeData(widget.devices[index].id);
                    // patchAgvStatusController
                    //     .initializeData(widget.devices[index].id);
                    // patchAgvDriveDistancController
                    //     .initializeData(widget.devices[index].id);
                    // patchAgvBatterLevelController
                    //     .initializeData(widget.devices[index].id);

                    // 선택된 행 초기화
                    selectedRowIndex = null;
                    selectedRows.clear();
                    Navigator.pop(context); // 다이얼로그 닫기
                  },
                  child: Text('수정 확인'),
                ),
                TextButton(
                  onPressed: () {
                    // 삭제 버튼을 눌렀을 때 호출되는 함수
                    //deleteDeviceController
                    //  .initializeData(widget.devices[index].id);
                    // 선택된 행 삭제
                    widget.cobots.removeAt(index);
                    widget.devices.removeAt(index);

                    // 선택된 행 초기화
                    selectedRowIndex = null;
                    selectedRows.clear();
                    print(index);
                    Navigator.pop(context); // 다이얼로그 닫기
                  },
                  child: Text('삭제'),
                ),
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
    // 선택된 행에 대한 삭제 로직 구현
    if (selectedRowIndex != null) {
      setState(() {
        // 삭제 전에 초기화
        //deleteDeviceController.initializeData(widget.devices[index].id);

        print('야야${index}');

        // 선택된 행 삭제
        widget.cobots.removeAt(index);
        widget.devices.removeAt(index);

        // 선택된 행 초기화
        selectedRowIndex = null;
        selectedRows.clear();
      });
    }
  }
}

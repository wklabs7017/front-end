import 'dart:math';

import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/agv.dart';
import 'package:bsn_v2/model/cobot.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 나머지 import 문들...
class CustomAgvStatusDataTable extends StatelessWidget {
  final RxList<AGV> agvs; // RxList
  final RxList<Device> devices; // RxList

  CustomAgvStatusDataTable({required this.agvs, required this.devices});

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
                    paddedCell('No.', 9, Colors.blue),
                    paddedCell('장비 이름', 9, Colors.blue),
                    paddedCell('연결 상태', 9, Colors.blue),
                    paddedCell('작동 모드', 9, Colors.blue),
                    paddedCell('현재 상태', 9, Colors.blue),
                    paddedCell('총 주행거리', 9, Colors.blue),
                    paddedCell('배터리 잔량', 9, Colors.blue),
                    paddedCell('마지막 연결 시간', 9, Colors.blue),
                    paddedCell('활동 기록', 9, Colors.blue),
                    paddedCell('정비 기록', 9, Colors.blue),
                  ],
                ),
              ] +
              _generateRows(),
        )));
  }

  List<TableRow> _generateRows() {
    List<TableRow> rows = [];
    // 가장 작은 리스트 길이를 기준으로 반복 횟수 결정
    int loopCount = min(agvs.length, devices.length);

    for (int i = 0; i < loopCount; i++) {
      rows.add(TableRow(
        children: <Widget>[
          // AGV 정보 4개 셀
          paddedCell(agvs[i].mode, 12, Colors.black),
          paddedCell(agvs[i].status, 12, Colors.black),
          paddedCell('${agvs[i].batteryLevel}%', 12, Colors.black),
          paddedCell('${agvs[i].driveDistance}m', 12, Colors.black),
          // Device 정보 6개 셀
          paddedCell(devices[i].name, 12, Colors.black),
          paddedCell(devices[i].modelName, 12, Colors.black),
          paddedCell(devices[i].type, 12, Colors.black),
          paddedCell(DateFormat('yyyy-MM-dd').format(devices[i].equippedAt), 12,
              Colors.black),
          paddedCell(devices[i].manufacturerName, 12, Colors.black),
          paddedCell(devices[i].manufacturerContact, 12, Colors.black),
        ],
      ));
    }

    return rows;
  }

  Widget paddedCell(String text, double fontSize, Color color) {
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Center(
          child: Column(
        children: [
          Text(text,
              style: AppTextStyles.bold
                  .copyWith(fontSize: fontSize, color: color)),
          SizedBox(height: 10),
        ],
      )),
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
        paddedCell(id, 12, Colors.black),
        paddedCell(name, 12, Colors.black),
        paddedCell(connectionStatus, 12, Colors.black),
        paddedCell(operationStatus, 12, Colors.black),
        paddedCell(lastConnection, 12, Colors.black),
        paddedCell(operationStatus2, 12, Colors.black),
        paddedCell(lastConnection2, 12, Colors.black),
        paddedCell(lastConnection3, 12, Colors.black), // 새로운 매개변수 사용
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
}

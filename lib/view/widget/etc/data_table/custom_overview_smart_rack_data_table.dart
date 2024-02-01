import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 나머지 import 문들...
class CustomOverviewSmartRackStatusDataTable extends StatelessWidget {
  final RxList<SmartRack> smartRacks; // RxList

  CustomOverviewSmartRackStatusDataTable({required this.smartRacks});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(25.0), // 첫 번째 열의 너비를 40.0으로 고정

              5: FixedColumnWidth(80.0), // 첫 번째 열의 너비를 40.0으로 고정
            },
            border: TableBorder.all(
              color: Colors.transparent,
              width: 30,
            ),
            children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    children: [
                      paddedCell('No.', 9, Colors.blue),
                      paddedCell('랙 이름', 9, Colors.blue),
                      paddedCell('관수 상태', 9, Colors.blue),
                      paddedCell('적재 상태', 9, Colors.blue),
                      paddedCell('LED 상태', 9, Colors.blue),
                      paddedCell('마지막 연결 시간', 9, Colors.blue),
                    ],
                  ),
                ] +
                smartRacks.map((smartRack) {
                  return tableRowWithPadding(
                    smartRack.id.toString(),
                    smartRack.ledMode,
                    smartRack.ledMode,
                    smartRack.ledMode,
                    smartRack.ledMode,
                  );
                }).toList(),
          ),
        ));
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

  TableRow tableRowWithPadding(String id, String name, String connectionStatus,
      String operationStatus, String lastConnection) {
    return TableRow(
      children: [
        paddedCell(id, 12, Colors.black),
        paddedCell(name, 12, Colors.black),
        paddedCell(connectionStatus, 12, Colors.black),
        paddedCell(operationStatus, 12, Colors.black),
        paddedCell(lastConnection, 12, Colors.black),
      ],
    );
  }
}

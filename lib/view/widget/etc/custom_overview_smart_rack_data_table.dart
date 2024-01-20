import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 나머지 import 문들...
class CustomSmartRackStatusDataTable extends StatelessWidget {
  final RxList<SmartRack> smartRacks; // RxList

  CustomSmartRackStatusDataTable({required this.smartRacks});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(
              color: Colors.transparent,
              width: 30,
            ),
            children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.blue),
                      ),
                    ),
                    children: [
                      paddedCell('No.', 14, Colors.blue),
                      paddedCell('랙 이름', 14, Colors.blue),
                      paddedCell('관수 상태', 14, Colors.blue),
                      paddedCell('적재 상태', 14, Colors.blue),
                      paddedCell('LED 상태', 14, Colors.blue),
                      paddedCell('마지막 연결 시간', 14, Colors.blue),
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
      child: Text(text, style: TextStyle(fontSize: fontSize, color: color)),
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

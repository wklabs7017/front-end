import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/cobot.dart';
import 'package:bsn_v2/model/converyor.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 나머지 import 문들...
class CustomSmartRackStatusDataTable extends StatelessWidget {
  final RxList<SmartRack> smartRacks; // RxList
  final RxList<Device> devices; // RxList

  CustomSmartRackStatusDataTable(
      {required this.smartRacks, required this.devices});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
              border: TableBorder.all(
                color: Colors.transparent,
                width: 1,
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
                        paddedCell('장비 이름', 9, Colors.blue),
                        paddedCell('연결 상태', 9, Colors.blue),
                        paddedCell('관수 모드', 9, Colors.blue),
                        paddedCell('LED 모드', 9, Colors.blue),
                        paddedCell('현재 상태', 9, Colors.blue),
                        paddedCell('마지막 연결 시간', 9, Colors.blue),
                        paddedCell('활동 기록', 9, Colors.blue),
                        paddedCell('정비 기록', 9, Colors.blue),
                      ],
                    ),
                  ] +
                  smartRacks.map((smartRack) {
                    return tableRowWithPadding(
                      smartRack.number.toString(),
                      smartRack.ledMode.toString(),
                    );
                  }).toList()),
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

  TableRow tableRowWithPadding(
    String id,
    String name,
    // String connectionStatus,
    // String operationStatus, String lastConnection
  ) {
    return TableRow(
      children: [
        paddedCell(id, 12, Colors.black),
        paddedCell(name, 12, Colors.black),
        // paddedCell(connectionStatus, 12, Colors.black),
        // paddedCell(operationStatus, 12, Colors.black),
        // paddedCell(lastConnection, 12, Colors.black),
      ],
    );
  }
}

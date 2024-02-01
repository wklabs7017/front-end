import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/task.dart';
import 'package:bsn_v2/model/task_devices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 나머지 import 문들...
class CustomTaskManagementDataTable extends StatelessWidget {
  final RxList<Task> task;
  CustomTaskManagementDataTable({super.key, required this.task});

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
                      paddedCell('No.', 14, Colors.blue),
                      paddedCell('작업 종류', 14, Colors.blue),
                      paddedCell('생성 일자', 14, Colors.blue),
                      paddedCell('시작 일시', 14, Colors.blue),
                      paddedCell('종료 일시', 14, Colors.blue),
                      paddedCell('AGV', 14, Colors.blue),
                      paddedCell('컨베이어', 14, Colors.blue),
                      paddedCell('스마트랙', 14, Colors.blue),
                      paddedCell('작업 상태', 14, Colors.blue),
                    ],
                  ),
                ] +
                task.map((task) {
                  return tableRowWithPadding(
                    task.name,
                    task.name,
                    task.name,
                    task.name,
                    task.name,
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

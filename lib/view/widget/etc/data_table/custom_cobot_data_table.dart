import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/cobot.dart';
import 'package:bsn_v2/model/device.dart';

class CustomCobotStatusDataTable extends StatelessWidget {
  final RxList<Cobot> cobots; // RxList
  final RxList<Device> devices; // RxList

  CustomCobotStatusDataTable({required this.cobots, required this.devices});

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
                        bottom: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                    children: [
                      paddedCell('No.', 15, Colors.blue),
                      paddedCell('장비 이름', 15, Colors.blue),
                      paddedCell('연결 상태', 15, Colors.blue),
                      paddedCell('작동 모드', 15, Colors.blue),
                      paddedCell('현재 상태', 15, Colors.blue),
                      paddedCell('마지막 연결 시간', 15, Colors.blue),
                      paddedCell('활동 기록', 15, Colors.blue),
                      paddedCell('정비 기록', 15, Colors.blue),
                    ],
                  ),
                ] +
                // Combine cobots and devices data
                (cobots.length > devices.length
                    ? cobots.map((cobot) {
                        final device = devices[cobots.indexOf(cobot)];
                        return tableRowWithPadding(
                            device.id.toString(),
                            device.name,
                            cobot.status.toString(),
                            cobot.mode,
                            device.equippedAt.toString(),
                            device.type,
                            device.modelName);
                      }).toList()
                    : devices.map((device) {
                        final cobot = cobots[devices.indexOf(device)];
                        return tableRowWithPadding(
                          device.id.toString(),
                          device.name,
                          cobot.status.toString(),
                          cobot.mode,
                          device.type,
                          device.tenantId.toString(),
                          device.modelName,
                        );
                      }).toList()),
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

  TableRow tableRowWithPadding(
      String id,
      String name,
      String connectionStatus,
      String operationStatus,
      String lastConnection,
      String deviceName,
      String deviceStatus) {
    return TableRow(
      children: [
        paddedCell(id, 12, Colors.black),
        paddedCell(name, 12, Colors.black),
        paddedCell(connectionStatus, 12, Colors.black),
        paddedCell(operationStatus, 12, Colors.black),
        paddedCell(lastConnection, 12, Colors.black),
        paddedCell(deviceName, 12, Colors.black),
        paddedCell(deviceStatus, 12, Colors.black),
      ],
    );
  }
}

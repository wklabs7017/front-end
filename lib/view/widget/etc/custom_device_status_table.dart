import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/device.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDeviceStatusTable extends StatefulWidget {
  final List<Device> getDeviceStatus;

  const CustomDeviceStatusTable({Key? key, required this.getDeviceStatus})
      : super(key: key);

  @override
  _CustomDeviceStatusTableState createState() =>
      _CustomDeviceStatusTableState();
}

class _CustomDeviceStatusTableState extends State<CustomDeviceStatusTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.talbeTextColor,
                  width: 2.0, // 테두리 두께
                ),
              ),
            ),
            child: PaginatedDataTable2(
              columns: [
                DataColumn(
                    label: Column(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text(
                        '장비 종류',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.talbeTextColor),
                      ),
                    ),
                  ],
                )),
                DataColumn(
                    label: Text('장비 이름',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.talbeTextColor))),
                DataColumn(
                    label: Text('연결 상태',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.talbeTextColor))),
                DataColumn(
                    label: Text('작동 상태',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.talbeTextColor))),
                DataColumn(
                    label: Text('마지막 연결 시간',
                        style: AppTextStyles.medium
                            .copyWith(color: AppColors.talbeTextColor))),
              ],
              source: DeviceStatusDataSource(
                  getDeviceStatus: widget
                      .getDeviceStatus), // 수정된 부분            rowsPerPage: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class DeviceStatusDataSource extends DataTableSource {
  final List<Device> getDeviceStatus;

  DeviceStatusDataSource({required this.getDeviceStatus});

  @override
  DataRow? getRow(int index) {
    if (index >= getDeviceStatus.length) return null;
    final deviceStatus = getDeviceStatus[index];

    return DataRow(cells: [
      DataCell(Text(deviceStatus.id.toString() ?? 'x')), // .toString() 추가
      DataCell(Text(deviceStatus.name)),
      DataCell(Text(deviceStatus.manufacturerName)),
      DataCell(Text(deviceStatus.manufacturerContact)),
      DataCell(Text(deviceStatus.type)),
      DataCell(Text(deviceStatus.tenantId.toString())),
      DataCell(Text(deviceStatus.equippedAt.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => getDeviceStatus.length; // 수정

  @override
  int get selectedRowCount => 0;
}

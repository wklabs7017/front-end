import 'package:bsn_v2/const/app_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/model/smart_rack.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomSmartRackStatusTable extends StatefulWidget {
  final List<SmartRack> getDeviceSmartRackStatus;

  const CustomSmartRackStatusTable(
      {Key? key, required this.getDeviceSmartRackStatus})
      : super(key: key);

  @override
  _CustomSmartRackStatusTableState createState() =>
      _CustomSmartRackStatusTableState();
}

class _CustomSmartRackStatusTableState
    extends State<CustomSmartRackStatusTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PaginatedDataTable2(
            columns: [
              DataColumn(
                  label: SizedBox(
                width: 50,
                child: Text(
                  '장비 종류',
                  style: AppTextStyles.medium
                      .copyWith(color: AppColors.talbeTextColor),
                ),
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
            source: SmartRackStatusDataSource(
                getDeviceSmartRackStatus: widget
                    .getDeviceSmartRackStatus), // 수정된 부분            rowsPerPage: 10,
          ),
        ],
      ),
    );
  }
}

class SmartRackStatusDataSource extends DataTableSource {
  final List<SmartRack> getDeviceSmartRackStatus;

  SmartRackStatusDataSource({required this.getDeviceSmartRackStatus});

  @override
  DataRow? getRow(int index) {
    if (index >= getDeviceSmartRackStatus.length) return null;
    final smartRackStatus = getDeviceSmartRackStatus[index];

    return DataRow(cells: [
      DataCell(Text(smartRackStatus.id.toString() ?? 'x')), // .toString() 추가
      DataCell(Text(smartRackStatus.ledMode)),
      DataCell(Text(smartRackStatus.ledOn.toString())),
      DataCell(Text(smartRackStatus.number.toString())),
      DataCell(Text(smartRackStatus.lastWorkedAt.toString())),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => getDeviceSmartRackStatus.length; // 수정

  @override
  int get selectedRowCount => 0;
}

import 'package:bsn_v2/model/user.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class CustomUserManagementTable extends StatefulWidget {
  final List<User> users;

  const CustomUserManagementTable({Key? key, required this.users})
      : super(key: key);

  @override
  _CustomUserManagementTableState createState() =>
      _CustomUserManagementTableState();
}

class _CustomUserManagementTableState extends State<CustomUserManagementTable> {
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable2(
      header: Text('사용자 관리'),
      columns: const [
        DataColumn(label: Text('id')),
        DataColumn(label: Text('이름')),
        DataColumn(label: Text('이메일')),
        DataColumn(label: Text('사용자')),
        DataColumn(label: Text('권한')),
      ],
      source: UserDataDataSource(widget.users),
      rowsPerPage: 10,
    );
  }
}

class UserDataDataSource extends DataTableSource {
  final List<User> users;

  UserDataDataSource(this.users);

  @override
  DataRow? getRow(int index) {
    if (index >= users.length) return null;
    final user = users[index];

    return DataRow(cells: [
      DataCell(Text(user.id.toString())),
      DataCell(Text(user.name)),
      DataCell(Text(user.email)),
      DataCell(Text(user.tenant.toString())),
      DataCell(Text(user.privilege)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => users.length;

  @override
  int get selectedRowCount => 0;
}

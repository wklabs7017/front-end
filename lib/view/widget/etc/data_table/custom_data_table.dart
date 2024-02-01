import 'package:flutter/material.dart';

class CustomDataTable extends StatefulWidget {
  final List<String> header;
  final List<List<String>> data;

  CustomDataTable({required this.header, required this.data});

  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  ScrollController _horizontalController = ScrollController();
  ScrollController _verticalController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: _horizontalController,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: _verticalController,
        child: DataTable(
          headingRowHeight: 40, // 헤더의 높이 조절
          columns:
              widget.header.map((e) => DataColumn(label: Text(e))).toList(),
          rows: widget.data.map((row) {
            return DataRow(
              cells: row.map((cell) => DataCell(Text(cell))).toList(),
            );
          }).toList(),
        ),
      ),
    );
  }
}

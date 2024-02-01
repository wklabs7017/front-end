import 'package:flutter/material.dart';

class DatePickerDropdown extends StatefulWidget {
  @override
  _DatePickerDropdownState createState() => _DatePickerDropdownState();
}

class _DatePickerDropdownState extends State<DatePickerDropdown> {
  DateTime? selectedDate;

  // 예시로 몇 가지 날짜를 제공합니다.
  final List<DateTime> dates = List.generate(
    10,
    (index) => DateTime.now().subtract(Duration(days: index * 3)),
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButton<DateTime>(
      value: selectedDate,
      hint: Text('날짜 선택'),
      onChanged: (newValue) {
        setState(() {
          selectedDate = newValue;
        });
      },
      items: dates.map((date) {
        return DropdownMenuItem<DateTime>(
          value: date,
          child: Text("${date.year}-${date.month}-${date.day}"),
        );
      }).toList(),
    );
  }
}

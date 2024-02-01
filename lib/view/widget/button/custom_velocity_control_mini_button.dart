import 'package:flutter/material.dart';

class CustomVelocityControlMiniButton extends StatefulWidget {
  final String title; // 위젯의 제목 (선속도 or 각속도)
  final double initialValue; // 초기값
  final ValueChanged<double> onValueChanged; // 값이 변경될 때 호출되는 콜백 함수

  const CustomVelocityControlMiniButton({
    Key? key,
    required this.title,
    required this.initialValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  _CustomVelocityControlMiniButtonState createState() =>
      _CustomVelocityControlMiniButtonState();
}

class _CustomVelocityControlMiniButtonState
    extends State<CustomVelocityControlMiniButton> {
  late double currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: currentValue,
                min: 0.0,
                max: 100.0,
                divisions: 100,
                label: currentValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    currentValue = value;
                  });
                  widget.onValueChanged(value);
                },
              ),
            ),
            SizedBox(width: 10),
            Text(
              currentValue.toStringAsFixed(2),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VelocityControlPanel extends StatefulWidget {
  String title;

  VelocityControlPanel({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _VelocityControlPanelState createState() => _VelocityControlPanelState();
}

class _VelocityControlPanelState extends State<VelocityControlPanel> {
  double _currentValue = 1.0;

  void _increaseValue() {
    setState(() {
      _currentValue += 1.0; // Or the increment you desire
    });
  }

  void _decreaseValue() {
    setState(() {
      _currentValue -= 1.0; // Or the decrement you desire
      if (_currentValue < 0)
        _currentValue = 0; // Prevent negative values if required
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '${widget.title}',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        InkWell(
          onTap: _increaseValue,
          child: Container(
            width: 56,
            height: 42,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF1F1F1),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFCACACA)),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 66,
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          '$_currentValue',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        InkWell(
          onTap: _decreaseValue,
          child: Container(
            width: 56,
            height: 42,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFF1F1F1),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Color(0xFFCACACA)),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 66,
                  child: Text(
                    '-',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

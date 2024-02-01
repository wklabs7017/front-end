import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomEmergencyStopButton extends StatefulWidget {
  const CustomEmergencyStopButton({super.key});

  @override
  _CustomEmergencyStopButtonState createState() =>
      _CustomEmergencyStopButtonState();
}

class _CustomEmergencyStopButtonState extends State<CustomEmergencyStopButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () {
          // 버튼 탭 시 실행할 작업
        },
        child: Container(
          margin: EdgeInsets.all(5),
          width: 70,
          height: 40.h,
          decoration: BoxDecoration(
            color: _isHovering
                ? Color(0xFF8A0000)
                : Color(0xFFD40000), // 호버 상태에 따라 색상 변경
            borderRadius: BorderRadius.circular(33),
            boxShadow: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 16.50,
                offset: Offset(4, 4),
                spreadRadius: -4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              '긴급정지',
              style: AppTextStyles.medium
                  .copyWith(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMiniTaskButton extends StatefulWidget {
  double? width;
  double? height;

  final String text;

  final Color color;

  void Function()? onTap;
  CustomMiniTaskButton(
      {super.key,
      required this.text,
      required this.color,
      required this.onTap,
      this.width,
      this.height});

  @override
  _CustomMiniTaskButtonState createState() => _CustomMiniTaskButtonState();
}

class _CustomMiniTaskButtonState extends State<CustomMiniTaskButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: EdgeInsets.all(0),
          width: 100,
          height: 35,
          decoration: BoxDecoration(
            color: _isHovering ? null : widget.color, // 호버 상태에 따라 색상 변경
            borderRadius: BorderRadius.circular(15),
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
              widget.text,
              style: AppTextStyles.medium
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}

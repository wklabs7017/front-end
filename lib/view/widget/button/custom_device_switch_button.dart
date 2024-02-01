import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomDeviceControlSwitchButton extends StatefulWidget {
  const CustomDeviceControlSwitchButton({super.key});

  @override
  State<CustomDeviceControlSwitchButton> createState() =>
      _CustomDeviceControlSwitchButtonState();
}

class _CustomDeviceControlSwitchButtonState
    extends State<CustomDeviceControlSwitchButton> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSwitched = !isSwitched;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: 40.0,
        width: 300.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: isSwitched ? Colors.grey.shade300 : Colors.grey.shade300,
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
              top: 3,
              bottom: 3,
              left: isSwitched
                  ? 150.0
                  : 0.0, // 500.0(width) - 100.0(Container width)
              right: isSwitched ? 0.0 : 150.0,
              child: Container(
                child: Center(
                  child: Text(
                    isSwitched ? '수동' : '자동',
                    style: AppTextStyles.bold
                        .copyWith(fontSize: 14, color: Colors.white),
                  ),
                ),
                height: 10, // 약간 작게 설정하여 테두리가 보이도록 함
                width: 300.0,
                decoration: BoxDecoration(
                  color: isSwitched ? Colors.red : Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

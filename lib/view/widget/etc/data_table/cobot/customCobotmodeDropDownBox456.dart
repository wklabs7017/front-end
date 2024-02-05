import 'dart:io';

import 'package:bsn_v2/const/app_text_style.dart';
import 'package:bsn_v2/controller/device/agv_device/get_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/patch_device_agv_mode_controller.dart';
import 'package:bsn_v2/controller/device/agv_device/post_device_agv_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/get_device_cobot_status_controller.dart';
import 'package:bsn_v2/controller/device/cobot_device/patch_device_cobot_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:bsn_v2/const/app_colors.dart';
import 'package:get/get.dart';

class CustomCobotModeDropDownBox456 extends StatefulWidget {
  final String label;
  final String? text; // 이제 text는 초기 선택된 값으로 사용됩니다.

  CustomCobotModeDropDownBox456({
    Key? key,
    required this.label,
    this.text,
  }) : super(key: key);

  @override
  _CustomCobotModeDropDownBox456State createState() =>
      _CustomCobotModeDropDownBox456State();
}

var patchController = Get.find<PatchDeviceCobotModeController>();
var getController = Get.find<GetDeviceCobotStatusController>();

class _CustomCobotModeDropDownBox456State
    extends State<CustomCobotModeDropDownBox456> {
  bool _isEditing = false;
  String? _selectedValue;

  final List<String> dropdownOptions2 = ['AUTO', 'MANUAL'];

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.text; // 초기 선택된 값 설정
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 50,
            height: 40,
            child: Center(
              child: Text(
                widget.label,
                style: AppTextStyles.medium
                    .copyWith(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onDoubleTap: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: AppColors.backgroundColor),
              ),
              child: _isEditing
                  ? DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppColors.backgroundColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: AppColors.backgroundColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0), // 컨텐트 패딩 설정
                      ),
                      style: AppTextStyles.medium
                          .copyWith(color: Colors.black), // 선택된 항목의 스타일 설정

                      value: dropdownOptions2
                              .contains(patchController.modeController.text)
                          ? patchController.modeController.text
                          : null,
                      items: dropdownOptions2.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: AppTextStyles.medium
                                .copyWith(color: Colors.black),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          patchController.modeController.text = newValue;
                        }
                      },
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Text(
                          _selectedValue ?? '',
                          style: AppTextStyles.medium.copyWith(fontSize: 13),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:bsn_v2/const/App_colors.dart';
import 'package:bsn_v2/const/app_text_style.dart';

class CustomDetailDropbox extends StatefulWidget {
  final String label;
  final String text;

  TextEditingController? controller;

  CustomDetailDropbox(
      {Key? key, required this.label, required this.text, this.controller})
      : super(key: key);

  @override
  _CustomDetailDropboxState createState() => _CustomDetailDropboxState();
}

class _CustomDetailDropboxState extends State<CustomDetailDropbox> {
  bool _isEditing = false;

  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              width: 50,
              height: 40,
              child: Center(
                child: Text(
                  widget.label,
                  style: AppTextStyles.medium
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
              )),
        ),
        SizedBox(width: 5),
        Expanded(
          flex: 2,
          child: GestureDetector(
            onDoubleTap: () {
              setState(() {
                _isEditing = true; // 더블 탭 시 _isEditing을 true로 설정합니다.
              });
            },
            child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(width: 2, color: AppColors.backgroundColor)),
              child: _isEditing
                  ? Container(
                      width: 200,
                      height: 40,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: AppColors.screenBackgroundColor),
                          borderRadius: BorderRadiusDirectional.circular(10)),
                      child: TextField(
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.transparent))),
                        controller: controller,
                        style: AppTextStyles.medium.copyWith(fontSize: 13),
                        onSubmitted: (value) {
                          setState(() {
                            _isEditing =
                                false; // 제출 시 _isEditing을 false로 설정합니다.
                          });
                        },
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.text,
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

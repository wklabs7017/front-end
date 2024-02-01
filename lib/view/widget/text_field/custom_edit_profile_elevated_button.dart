import 'package:flutter/material.dart';

class CustomEditProfileElevatedButton extends StatefulWidget {
  CustomEditProfileElevatedButton({super.key});

  @override
  State<CustomEditProfileElevatedButton> createState() =>
      _CustomEditProfileElevatedButtonState();
}

class _CustomEditProfileElevatedButtonState
    extends State<CustomEditProfileElevatedButton> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(_isEditing ? '저장' : '수정'),
      onPressed: () {
        setState(() {
          _isEditing = !_isEditing;
          // 여기에 프로필 저장 로직을 추가할 수 있습니다.
        });
      },
    );
  }
}

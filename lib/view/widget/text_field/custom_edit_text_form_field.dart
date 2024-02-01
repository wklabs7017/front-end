import 'package:flutter/material.dart';

class EditableProfileWidget extends StatefulWidget {
  @override
  _EditableProfileWidgetState createState() => _EditableProfileWidgetState();
}

class _EditableProfileWidgetState extends State<EditableProfileWidget> {
  bool _isEditing = false;
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: "기존 프로필 정보");
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _isEditing
            ? TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: '프로필',
                  border: OutlineInputBorder(),
                ),
              )
            : Text(
                _controller!.text,
                style: TextStyle(fontSize: 18),
              ),
        SizedBox(height: 10),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomBasicAlert extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onPressed;
  final bool showCancelButton; // Cancel 버튼 표시 여부를 결정하는 매개변수

  CustomBasicAlert({
    super.key,
    required this.title,
    required this.content,
    this.onPressed,
    this.showCancelButton = true, // 기본값은 true로 설정
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    if (showCancelButton) {
      actions.add(
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // 대화상자 닫기
          },
        ),
      );
    }

    actions.add(
      Center(
        child: TextButton(
          child: const Text('OK'),
          onPressed: onPressed,
        ),
      ),
    );

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
      actions: actions,
    );
  }
}

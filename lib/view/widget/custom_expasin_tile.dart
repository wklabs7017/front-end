import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;

  final Color? color;

  CustomExpansionTile(
      {Key? key,
      required this.title,
      required this.children,
      required this.color})
      : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(widget.title,
                style: AppTextStyles.medium.copyWith(color: Colors.white)),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            trailing: Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
            ),
          ),
          if (_isExpanded) ...widget.children,
        ],
      ),
    );
  }
}

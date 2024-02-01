import 'package:bsn_v2/const/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:bsn_v2/const/app_colors.dart';

class CustomTenantListTileDetail extends StatefulWidget {
  final String label;
  final String text;

  CustomTenantListTileDetail(
      {Key? key, required this.label, required this.text})
      : super(key: key);

  @override
  _CustomTenantListTileDetailState createState() =>
      _CustomTenantListTileDetailState();
}

class _CustomTenantListTileDetailState
    extends State<CustomTenantListTileDetail> {
  bool _isEditing = false;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.text;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(10)),
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
                _isEditing = true;
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
                  ? TextField(
                      controller: _controller,
                      style: AppTextStyles.medium.copyWith(fontSize: 13),
                      onSubmitted: (value) {
                        setState(() {
                          _isEditing = false;
                        });
                      },
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

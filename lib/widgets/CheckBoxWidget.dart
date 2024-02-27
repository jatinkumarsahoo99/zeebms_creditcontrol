import 'package:flutter/material.dart';

import '../app/providers/SizeDefine.dart';

class CheckBoxWidget1 extends StatelessWidget {
  final String title;
  bool value;
  final void Function(bool?)? onChanged;
  final bool isEnable;
  final bool showIcon;
  final double? horizontalPadding;
  final double? verticalPadding;
  final IconData iconData;
  final FocusNode? fn;
  CheckBoxWidget1({
    Key? key,
    required this.title,
    this.value = false,
    this.onChanged,
    this.isEnable = true,
    this.horizontalPadding,
    this.verticalPadding,
    this.iconData = Icons.done,
    this.showIcon = false,
    this.fn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 5, vertical: verticalPadding ?? 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StatefulBuilder(builder: (context, re) {
            return Checkbox(
              value: value,
              focusNode: fn,
              onChanged:(isEnable)? (newVal) {
                value = (newVal ?? false);
                re(() {});
                if (onChanged != null) {
                  onChanged!(value);
                }
              }:null,
            );
          }),
          if (showIcon) ...{
            Tooltip(
              message: title,
              child: Icon(
                iconData,
                color: Colors.deepPurpleAccent,
                size: 18,
              ),
            ),
          } else ...{
            Text(
              title,
              style: TextStyle(
                color: isEnable ? Colors.black : Colors.grey,
                fontSize: 13,
              ),
            )
          }
        ],
      ),
    );
  }
}

class CheckBoxOnRight extends StatelessWidget {
  final String title;
  bool value;
  final void Function(bool?)? onChanged;
  final bool isEnable;
  final bool showIcon;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final IconData iconData;
  final FocusNode? fn;
  CheckBoxOnRight({
    Key? key,
    required this.title,
    this.value = false,
    this.onChanged,
    this.isEnable = true,
    this.top,
    this.bottom,
    this.iconData = Icons.done,
    this.showIcon = false,
    this.fn,
    this.right,
    this.left
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: top ?? 14, bottom: bottom ?? 0,left: left??0,right: right??0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...{
            Tooltip(
              message: title,
              child: Icon(
                iconData,
                color: Colors.deepPurpleAccent,
                size: 18,
              ),
            ),
          } else ...{
            Text(
              title,
              style: TextStyle(
                fontSize: SizeDefine.labelSize1,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            )
          },
          StatefulBuilder(builder: (context, re) {
            return Checkbox(
              value: value,
              focusNode: fn,
              // visualDensity: const VisualDensity(horizontal: -4),
              onChanged:(isEnable)? (newVal) {
                value = (newVal ?? false);
                re(() {});
                if (onChanged != null) {
                  onChanged!(value);
                }
              }:null,
            );
          }),
        ],
      ),
    );
  }
}

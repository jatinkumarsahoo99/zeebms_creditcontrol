import 'package:flutter/material.dart';

import '../app/providers/SizeDefine.dart';

class RadioRow1 extends StatefulWidget {
  final List items;
  final String groupValue;
  final bool? isVertical;
  final Function? onchange;
  final List<String>? disabledRadios;
  final double? rightPad;

  RadioRow1({
    Key? key,
    required this.items,
    required this.groupValue,
    this.onchange,
    this.isVertical,
    this.rightPad,
    this.disabledRadios,
  }) : super(key: key);

  @override
  State<RadioRow1> createState() => _RadioRow1State();
}

class _RadioRow1State extends State<RadioRow1> {
  @override
  Widget build(BuildContext context) {
    return (widget.isVertical ?? false)
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: buildRadio(),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: buildRadio(),
          );
  }

  buildRadio() {
    return widget.items
        .map(
          (e) => Padding(
            padding: EdgeInsets.only(left: 5, right: (widget.rightPad ?? 0)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio<String>(
                    value: e,
                    groupValue: widget.groupValue,
                    visualDensity: const VisualDensity(horizontal: -4),
                    onChanged: widget.disabledRadios?.contains(e) ?? false
                        ? null
                        : (value) {
                            widget.onchange!(value);
                          }),
                Text(
                  e,
                  style: TextStyle(
                    color: widget.disabledRadios?.contains(e) ?? false
                        ? Colors.grey
                        : Colors.black,
                    fontSize: SizeDefine.labelSize1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}

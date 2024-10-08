import 'package:flutter/material.dart';

import '../app/providers/SizeDefine.dart';

class LabelText {
  static Widget style({String? hint, Color? txtColor}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          hint ?? "",
          style: TextStyle(
            fontSize: SizeDefine.labelSize1,
            color: txtColor ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: SizeDefine.marginGap,
        ),
      ],
    );
  }
}

class LabelText2 {
  static Widget style({String? hint, Color? txtColor}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // crossAxisAlignment: titleSizeboxWidth != null : CrossAxisAlignment.start ? CrossAxisAlignment.end,
      children: [
        Text(
          hint ?? "",
          style: TextStyle(
            fontSize: SizeDefine.labelSize1,
            color: txtColor ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: SizeDefine.marginGap,
        ),
      ],
    );
  }
}

class LabelText3 {
  static Widget style({String? hint, Color? txtColor}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      // crossAxisAlignment: titleSizeboxWidth != null : CrossAxisAlignment.start ? CrossAxisAlignment.end,
      children: [
        Text(
          hint ?? "",
          style: TextStyle(
            fontSize: SizeDefine.labelSize1,
            color: txtColor ?? Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
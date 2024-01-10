import 'package:flutter/material.dart';

import '../app/providers/SizeDefine.dart';

Widget text_m_w700(String text, {Color color = Colors.black}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: SizeDefine.labelSizeMedium,
      fontWeight: FontWeight.w700,
      color: color,
    ),
  );
}

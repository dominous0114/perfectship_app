import 'dart:io';

import 'package:flutter/cupertino.dart';

double AutoFontSize(BuildContext context) {
  double size = 0.2;
  final double onePointTwo = 1.2;
  final width = MediaQuery.of(context).size.height;
  final fontSize = (50 / width) * width * size;
  return fontSize;
}

PlatformSize(BuildContext context) {
  var HFontSize = Platform.isAndroid
      ? AutoFontSize(context) * 1.3
      : AutoFontSize(context) * 1.4;
  return HFontSize;
}

import 'package:flutter/material.dart';

Widget CustomProgessIndicator(Color color, double size) {
  return SizedBox(
    width: size,
    height: size,
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(color),
      strokeWidth: 5.0,
    ),
  );
}

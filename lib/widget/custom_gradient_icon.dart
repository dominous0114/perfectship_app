import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData iconData;
  final double size;
  final Gradient gradient;

  GradientIcon({required this.iconData, required this.gradient, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Icon(iconData, size: size, color: Colors.white),
    );
  }
}

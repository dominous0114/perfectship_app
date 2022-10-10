import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistics {
  final String name;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  String total;

  Statistics({
    required this.name,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.total,
  });
}

class ChartData {
  ChartData({required this.xval, required this.yval});
  final String xval;
  final int yval;
}

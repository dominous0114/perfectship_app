import 'package:flutter/material.dart';

class StatusColor {
  late Color color;

  Color checkstatus(String status) {
    if (status == 'primary') {
      color = Colors.blue;
    } else if (status == 'secondary') {
      color = Colors.grey;
    } else if (status == 'success') {
      color = Colors.green;
    } else if (status == 'danger') {
      color = Colors.red;
    } else if (status == 'warning') {
      color = Colors.orange;
    } else if (status == 'info') {
      color = Colors.cyan;
    } else {
      color = Colors.white;
    }

    return color;
  }
}

import 'package:flutter/material.dart';
import 'package:perfectship_app/widget/hide_navbar.dart';

class Allkey {
  static final HideNavbar hiding = HideNavbar();

  static ScrollController orderScrollController = ScrollController();
  static ScrollController billScrollController = ScrollController();
  static ScrollController homeScrollController = ScrollController();
  static bool isSelected = false;
  static bool isSelectedAll = false;
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HideNavbar {
  final ScrollController controller = ScrollController();
  final ValueNotifier<bool> visible = ValueNotifier<bool>(true);

  HideNavbar() {
    visible.value = true;

    controller.addListener(
      () {
        if (controller.position.userScrollDirection == ScrollDirection.reverse) {
          // down
          visible.value = false;
        }
        if (controller.position.userScrollDirection == ScrollDirection.forward) {
          // up
          if (!visible.value) {
            visible.value = true;
          }
        }
        waitingForTime();
      },
    );
  }

  waitingForTime() async {
    await Future.delayed(Duration(seconds: 3), () {
      if (controller.position.userScrollDirection == ScrollDirection.idle) {
        if (!visible.value) {
          visible.value = true;
          print(controller.position.userScrollDirection);
        }
      }
    });
  }

  void dispose() {
    controller.dispose();
    visible.dispose();
  }
}

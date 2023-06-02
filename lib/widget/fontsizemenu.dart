import 'package:flutter/material.dart';

import 'fontsize.dart';

class CustomTextAutoSizeforMenu extends StatelessWidget {
  const CustomTextAutoSizeforMenu({Key? key, required this.bold, required this.text, required this.enable}) : super(key: key);
  final String text;
  final bool bold;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.normal, color: enable == true ? Colors.black54.withOpacity(.7) : Colors.grey, fontSize: PlatformSize(context) * 1.2),
    );
  }
}

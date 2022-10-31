import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'fontsize.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backArrow;
  final bool? addButton;
  final Widget? icon;
  final Function()? onPress;
  final Function()? onPressArrow;
  const CustomAppBar(
      {Key? key,
      required this.title,
      required this.backArrow,
      this.addButton,
      this.onPress,
      this.icon,
      this.onPressArrow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40),
      child: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(200, 43, 166, 223),
                Color.fromARGB(180, 41, 88, 162),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 0.8],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: PlatformSize(context) * 1.2),
        ),
        actions: [
          addButton == true
              ? IconButton(
                  onPressed: onPress,
                  icon: icon!,
                )
              : Container()
        ],
        /* shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),*/
        automaticallyImplyLeading: backArrow,
        leading: backArrow
            ? IconButton(
                onPressed: onPressArrow,
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              )
            : null,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70.0);
}

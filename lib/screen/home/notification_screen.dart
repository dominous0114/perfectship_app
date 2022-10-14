import 'package:flutter/material.dart';
import 'package:perfectship_app/widget/custom_appbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  static const String routeName = '/notification';

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        pageBuilder: (_, __, ___) => NotificationScreen());
  }

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Notifiation',
        backArrow: true,
        onPressArrow: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

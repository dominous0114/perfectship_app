import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:perfectship_app/config/navkey.dart';

@pragma('vm:entry-point')
onSelectNotification(NotificationResponse notificationResponse) async {
  print('on bg select');
  // Navigator.pushNamed(NavKey.navKey.currentContext!, '/notification');
}

class LocalNotficationService {
  static final FlutterLocalNotificationsPlugin _notificationplugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/launcher_icon"),
            iOS: DarwinInitializationSettings(
                requestAlertPermission: true,
                requestBadgePermission: true,
                requestSoundPermission: true));
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _notificationplugin.getNotificationAppLaunchDetails();

    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;
    if (didNotificationLaunchApp) {
      var payload = notificationAppLaunchDetails!.notificationResponse;
      onSelectNotification(payload!);
    } else {
      _notificationplugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification,
        onDidReceiveNotificationResponse: (details) {
          print('on push');
          print(context);
          // Navigator.pushNamed(context, '/notification');
        },
      );
    }
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              'perfectship-shipping', 'แจ้งเตือนการสถานะพัสดุ',
              importance: Importance.max,
              priority: Priority.high,
              icon: "@mipmap/launcher_icon"),
          iOS: DarwinNotificationDetails());
      await _notificationplugin.show(id, message.data['title'],
          '${message.data['body']} displayfore', notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }

  // static void testdisplay(String test) async {
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  //     final NotificationDetails notificationDetails = NotificationDetails(
  //         android: AndroidNotificationDetails(
  //             'perfectship-shipping', 'แจ้งเตือนการสถานะพัสดุ',
  //             importance: Importance.max,
  //             priority: Priority.high,
  //             icon: "@mipmap/launcher_icon"),
  //         iOS: DarwinNotificationDetails());
  //     await _notificationplugin.show(id, test, test, notificationDetails);
  //   } on Exception catch (e) {
  //     print(e);
  //   }
  // }

  static void displaybackground(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    RemoteNotification? remoteNotification = message.notification;
    final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            'perfectship-shipping', 'แจ้งเตือนการสถานะพัสดุ',
            importance: Importance.max,
            priority: Priority.high,
            icon: "@mipmap/launcher_icon"),
        iOS: DarwinNotificationDetails());

    await _notificationplugin.show(id, message.data['title'],
        '${message.data['body']} displayback', notificationDetails);
  }
}

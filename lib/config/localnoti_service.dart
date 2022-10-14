import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotficationService {
  static final FlutterLocalNotificationsPlugin _notificationplugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/launch_image'),
            iOS: DarwinInitializationSettings(
                requestAlertPermission: true,
                requestBadgePermission: true,
                requestSoundPermission: true));
    _notificationplugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {
        print('on bg push');
        print(context);
        Navigator.pushNamed(context, '/notification');
      },
      onDidReceiveNotificationResponse: (details) {
        print('on push');
        print(context);
        Navigator.pushNamed(context, '/notification');
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              'perfectship', 'perfectship channel',
              importance: Importance.max, priority: Priority.high),
          iOS: DarwinNotificationDetails());
      await _notificationplugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }

  static void testdisplay(String test) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              'perfectship', 'perfectship channel',
              importance: Importance.max, priority: Priority.high),
          iOS: DarwinNotificationDetails());
      await _notificationplugin.show(id, test, test, notificationDetails);
    } on Exception catch (e) {
      print(e);
    }
  }

  static void displaybackground(RemoteMessage message) async {
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    RemoteNotification? remoteNotification = message.notification;
    final NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            'perfectship', 'perfectship channel',
            importance: Importance.max, priority: Priority.high),
        iOS: DarwinNotificationDetails());
    if (remoteNotification != null) {
      await _notificationplugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    }
  }
}

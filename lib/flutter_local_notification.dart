import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FlutterLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {},
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }

  void showBasicNotification() async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails("channel_1", "Basic Notification"),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      "Dunia pasti berputar",
      "Tapi apakah itu benar",
      details,
    );
  }
}

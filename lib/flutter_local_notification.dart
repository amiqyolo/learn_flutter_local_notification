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
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  static onTap(NotificationResponse notificationResponse) {}

  static void showBasicNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      "channel_1",
      "Basic Notification",
      priority: Priority.high,
      importance: Importance.max,
    );
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
      1,
      "Dunia pasti berputar",
      "Tapi apakah itu benar",
      payload: "Payload Data",
      details,
    );
  }

  static void showRepeatedNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      "channel_2",
      "Repeated Notification",
      channelDescription: "repeating description",
      priority: Priority.high,
      importance: Importance.max,
    );
    NotificationDetails details = NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      2,
      "Dunia pasti berputar",
      "Tapi apakah itu sudah benar?",
      payload: "Payload Data",
      RepeatInterval.everyMinute,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

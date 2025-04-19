import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class FlutterLocalNotification {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

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

  static onTap(NotificationResponse notificationResponse) {
    // print("${notificationResponse.id}");
    // print("${notificationResponse.payload}");
    streamController.add(notificationResponse);
  }

  static void showBasicNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      "channel_1",
      "Basic Notification",
      channelDescription: "basic description",
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
      RepeatInterval.daily,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void showScheduleNotification() async {
    AndroidNotificationDetails android = AndroidNotificationDetails(
      "channel_3",
      "Schedule Notification",
      channelDescription: "scheduling description",
      priority: Priority.high,
      importance: Importance.max,
    );
    NotificationDetails details = NotificationDetails(android: android);
    tz.initializeTimeZones();
    print("${tz.local.name}, ${tz.TZDateTime.now(tz.local).hour}");
    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      "Dunia",
      "Itu Indah",
      payload: "Payload Data",
      // tz.TZDateTime.now(tz.local).add(Duration(seconds: 10)),
      tz.TZDateTime(
        tz.local,
        tz.TZDateTime.now(tz.local).year,
        tz.TZDateTime.now(tz.local).month,
        tz.TZDateTime.now(tz.local).day,
        tz.TZDateTime.now(tz.local).hour,
        58,
      ),
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static void cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}

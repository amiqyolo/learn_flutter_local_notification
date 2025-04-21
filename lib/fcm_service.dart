import 'dart:developer' as developer;
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FCMService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token ?? "No Token";
  }

  void isRefreshToken() {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      developer.log('TOken Refereshed');
    });
  }

  void interactMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleMessage(context, event);
    });
  }

  void foregroundNotification(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      developer.log("Notification title: ${notification?.title ?? "No title"}");
      developer.log("Notification title: ${notification?.body ?? "No Body"}");
      developer.log("Data: ${message.data}");

      if (Platform.isAndroid) {
        _initLocalNotification(context, message);
        _showNotification(message);
      }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      developer.log("user is already granted permisions");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      developer.log("user is already granted provisional permisions");
    } else {
      developer.log("User has denied permission");
    }
  }

  void _initLocalNotification(
    BuildContext context,
    RemoteMessage message,
  ) async {
    final androidSettings = AndroidInitializationSettings(
      "@mipmap/ic_launcher",
    );

    final initSetting = InitializationSettings(android: androidSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initSetting,
      onDidReceiveNotificationResponse:
          (details) => _handleMessage(context, message),
    );
  }

  void _handleMessage(BuildContext context, RemoteMessage details) {
    if (details.data["type"] == "text") {
      // redirect to new screen or take different action based on payload that you receive.
    }
  }

  void _showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: "Flutter Notification",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      ticker: "ticker",
      sound: channel.sound,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }
}

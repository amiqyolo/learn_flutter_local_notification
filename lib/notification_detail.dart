import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDetail extends StatelessWidget {
  const NotificationDetail({super.key, required this.response});

  final NotificationResponse response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("${response.id} + ${response.payload}")],
        ),
      ),
    );
  }
}

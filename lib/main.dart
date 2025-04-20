import 'package:flutter/material.dart';
import 'package:flutter_notification/flutter_local_notification.dart';

import 'notification_detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Future.wait([
  //   FlutterLocalNotification.init(),
  //   WorkManagerService().init(),
  // ]);

  await FlutterLocalNotification.init();
  // await WorkManagerService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void listenToNotificationStream() {
    FlutterLocalNotification.streamController.stream.listen((
      notificationResponse,
    ) {
      print("${notificationResponse.id}");
      print("${notificationResponse.payload}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => NotificationDetail(response: notificationResponse),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    listenToNotificationStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            onTap: () => FlutterLocalNotification.showBasicNotification(),
            leading: Icon(Icons.notifications),
            title: Text("Basic Notification"),
            trailing: IconButton(
              onPressed: () {
                FlutterLocalNotification.cancelNotification(1);
              },
              icon: Icon(Icons.cancel),
            ),
          ),
          ListTile(
            onTap: () => FlutterLocalNotification.showRepeatedNotification(),
            leading: Icon(Icons.notifications),
            title: Text("Repeated Notification"),
            trailing: IconButton(
              onPressed: () {
                FlutterLocalNotification.cancelNotification(2);
              },
              icon: Icon(Icons.cancel),
            ),
          ),
          ListTile(
            onTap: () => FlutterLocalNotification.showScheduleNotification(),
            leading: Icon(Icons.notifications),
            title: Text("Schedule Notification"),
            trailing: IconButton(
              onPressed: () {
                FlutterLocalNotification.cancelNotification(3);
              },
              icon: Icon(Icons.cancel),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              FlutterLocalNotification.flutterLocalNotificationsPlugin
                  .cancelAll();
            },
            child: Text("Clear All"),
          ),
        ],
      ),
    );
  }
}

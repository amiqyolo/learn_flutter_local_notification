// import 'package:flutter_notification/flutter_local_notification.dart';
// import 'package:workmanager/workmanager.dart';
//
// class WorkManagerService {
//   Future<void> init() async {
//     await Workmanager().initialize(actionTask, isInDebugMode: true);
//     // register task
//     registerTask();
//   }
//
//   void registerTask() async {
//     await Workmanager().registerOneOffTask("id_1", "Show simple notification");
//   }
//
//   void cancelTask(String id) {
//     Workmanager().cancelByUniqueName(id);
//   }
// }
//
// @pragma('vm:entry-point')
// void actionTask() {
//   // show notification
//   Workmanager().executeTask((taskName, inputData) {
//     FlutterLocalNotification.showBasicNotification();
//     return Future.value(true);
//   });
// }

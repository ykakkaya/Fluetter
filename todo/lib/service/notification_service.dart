import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/models/task.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
  }

  static Future showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payload);
  }

  static Future showScheduleNotification({
    required Task task,
  }) async {
    // tz.initializeTimeZones();
    var scheduleTime = tz.TZDateTime.from(task.createdDate, tz.local);
    int id = task.createdDate.millisecondsSinceEpoch ~/ 100000;
    if (task.createdDate.isAfter(DateTime.now())) {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          "HATIRLATMA",
          task.name,
          scheduleTime,
          const NotificationDetails(
              android: AndroidNotificationDetails(
            'schedule Notification', 'schedule todo',
            channelDescription: 'schedule todo list',
            importance: Importance.max,
            priority: Priority.high,
            // ticker: 'ticker'
          )),
          androidScheduleMode: AndroidScheduleMode.alarmClock,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: "");
    }
  }

  static Future deleteNotification(Task task) async {
    int id = task.createdDate.millisecondsSinceEpoch ~/ 100000;
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}

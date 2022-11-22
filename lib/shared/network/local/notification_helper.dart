// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:my_task/models/task.dart';
import '../../../main.dart';
import "package:timezone/data/latest.dart" as tz;
import 'package:timezone/timezone.dart' as tz;

class NotifyHelper
{
  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    print('MoaaZ');
    _configurationLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // onSelectNotification: selectNotification
    );
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  scheduledNotification({required int hour, required int minutes, required Task task}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Get yourself ready to get the task done',
        '${task.startTime}, ${task.title}',
        _convertTime(hour, minutes-10),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', channelDescription:'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );

  }

  scheduledNotification2({required int hour, required int minutes, required Task task}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        task.title,
        task.description,
        _convertTime(hour, minutes),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', channelDescription:'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time
    );

  }


  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id', 'your channel name', channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high);
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'MoaaZ Task',
      'Meeting MoaaZ !',
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future selectNotification(String payload) async {
    //Handle notification tapped logic here
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) => const CupertinoAlertDialog(
        title: Text('Notification'),
        content: Text('Go to Another Screen'),
      ),
    );
  }

  tz.TZDateTime _convertTime(int? hour, int? minutes)
  {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime handleDateTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour!, minutes!);
    if(handleDateTime.isBefore(now))
      {
        handleDateTime = handleDateTime.add(const Duration(days: 1));
      }
    return handleDateTime;
  }

 Future<void> _configurationLocalTimeZone()async
  {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }
}
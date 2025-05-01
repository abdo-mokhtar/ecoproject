import 'dart:convert';
import 'package:ecosensetest/services/api_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // طلب إذن الإشعارات
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(initializationSettings);
    print("Notifications initialized"); // للتصحيح
  }

  static Future<void> showNotification(String title, String body) async {
    if (await Permission.notification.isGranted) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'air_quality_channel',
        'Air Quality Alerts',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      );

      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      await _notificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch % 100000, // ID فريد لكل إشعار
        title,
        body,
        platformChannelSpecifics,
      );
      print("Notification sent: $title - $body");

      // حفظ الإشعار
      await saveNotification(title, body);
    } else {
      print("Notification permission not granted");
    }
  }

  // دالة جديدة لإرسال إشعارات لكل المحافظات
  static Future<void> showCityNotifications(
      List<Map<String, dynamic>> cities,
      List<AirQualityData> airQualityData,
      String Function(double) getTipsForAQI) async {
    for (int i = 0; i < cities.length; i++) {
      final city = cities[i];
      final data = airQualityData[i];
      if (data.aqi > 50) {
        final tips = getTipsForAQI(data.aqi);
        await showNotification(
          "${city['name']} Alert! AQI: ${data.aqi.round()}",
          "Air quality is not good.\nTips: $tips",
        );
      }
    }
  }

  // دالة لحفظ الإشعار
  static Future<void> saveNotification(String title, String body) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];

    final notificationData = {
      'title': title,
      'body': body,
      'timestamp': DateTime.now().toIso8601String(),
    };

    notifications.add(jsonEncode(notificationData));
    await prefs.setStringList('notifications', notifications);
    print("Notification saved: $title - $body");
  }

  // دالة لجلب الإشعارات المحفوظة
  static Future<List<Map<String, dynamic>>> getSavedNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> notifications = prefs.getStringList('notifications') ?? [];
    return notifications
        .map((n) => jsonDecode(n) as Map<String, dynamic>)
        .toList();
  }
}

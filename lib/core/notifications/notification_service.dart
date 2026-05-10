import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart'; // 👈 مهم: أضف permission_handler في pubspec.yaml
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// تهيئة الإشعارات وإنشاء القناة
  static Future<void> init() async {
    tzdata.initializeTimeZones();

    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings settings =
        InitializationSettings(android: androidInit);

    await _plugin.initialize(settings);

    // إنشاء قناة الإشعارات (بدون priority لأنه غير مدعوم هنا)
    final androidChannel = AndroidNotificationChannel(
      'med_channel',
      'تذكير الأدوية',
      description: 'قناة تنبيهات تذكير الدواء',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      sound: RawResourceAndroidNotificationSound('alarm'), // تأكد من وجود alarm.mp3 في res/raw
    );

    final androidPlugin =
        _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(androidChannel);
    }
  }

  /// طلب صلاحية التنبيه الدقيق (لازمة لـ exactAllowWhileIdle)
  static Future<bool> requestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isGranted) {
      return true;
    }
    final status = await Permission.scheduleExactAlarm.request();
    return status.isGranted;
  }

  /// جدولة إشعار بدواء
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    // تأكد من صلاحية التنبيه الدقيق أولًا
    final granted = await requestExactAlarmPermission();
    if (!granted) {
      throw Exception('يجب منح صلاحية التنبيه الدقيق من إعدادات التطبيق');
    }

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'med_channel',
          'Medicines',
          channelDescription: 'Medicine alarm channel',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          enableVibration: true,
          sound: RawResourceAndroidNotificationSound('alarm'),
          icon: '@mipmap/ic_launcher',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time, // يكرر يوميًا لو حابب
    );
  }
}
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_krainet/domain/entities/task.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

/// Service responsible for managing local notifications
/// Uses a singleton pattern to ensure only one instance exists
class NotificationService {
  // Private constructor for singleton implementation
  NotificationService._privateConstructor();

  // Singleton instance
  static final NotificationService instance =
      NotificationService._privateConstructor();

  // Flutter local notifications plugin instance
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Whether the service has been initialized
  bool _isInitialized = false;

  /// Initialize notification service with platform-specific settings
  Future<void> init() async {
    if (_isInitialized) return;

    // Initialize timezone data
    tz.initializeTimeZones();

    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS initialization settings
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // Initialize settings for both platforms
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Initialize the plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );

    _isInitialized = true;
  }

  /// Request notification permissions for iOS
  Future<void> requestIOSPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// Schedule a notification for a task
  /// The notification will be triggered at the task's date
  Future<void> scheduleTaskNotification(Task task) async {
    await _ensureInitialized();

    // Create Android notification details
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'task_channel_id',
      'Task Notifications',
      channelDescription: 'Channel for task notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    // Create iOS notification details
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    // Create notification details for all platforms
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    // Generate a unique notification ID from the task's UUID
    final int notificationId = task.id.hashCode;

    // Schedule the notification
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId,
      'Task Reminder: ${task.title}',
      task.description,
      tz.TZDateTime.from(task.date, tz.local),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: task.id,
    );
  }

  /// Cancel a scheduled notification for a task
  Future<void> cancelTaskNotification(Task task) async {
    await _ensureInitialized();
    // Convert the string ID to a consistent int using hashCode
    final int notificationId = task.id.hashCode;
    await _flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _ensureInitialized();
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Ensures that the notification service is initialized before use
  Future<void> _ensureInitialized() async {
    if (!_isInitialized) {
      await init();
    }
  }
}

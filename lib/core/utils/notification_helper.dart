import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'dart:io' show Platform;
import 'package:workmanager/workmanager.dart';

enum WorkManagerTacks {
  stepCounterNotification,
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    if (task == WorkManagerTacks.stepCounterNotification.name) {
      return NotificationsHelper.handleStepCounterNotificationTack();
    }
    return Future.value(false);
  });
}

@LazySingleton()
class NotificationsHelper {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    PermissionStatus permissionStatus = await _getCheckNotificationPermStatus();
    if (permissionStatus != PermissionStatus.granted) {
      return;
    }
    await Workmanager().initialize(callbackDispatcher);
    final now = DateTime.now();
    final isPastTodaysReminder = now.hour >= 20;
    final nextTask = DateTime(
      now.year,
      now.month,
      isPastTodaysReminder ? now.day + 1 : now.day,
      20,
      0,
    );
   final initialDelay = nextTask.difference(now);
    if (Platform.isAndroid) {
      await Workmanager().registerPeriodicTask(
        'notification_periodic_step_count',
        WorkManagerTacks.stepCounterNotification.name,
        existingWorkPolicy: ExistingWorkPolicy.replace,
        frequency: const Duration(days: 1),
        initialDelay: initialDelay,
      );
    } else if (Platform.isIOS) {
      await Workmanager().registerOneOffTask(
        'notification_one_off_step_count',
        WorkManagerTacks.stepCounterNotification.name,
        existingWorkPolicy: ExistingWorkPolicy.replace,
        initialDelay: initialDelay,
      );
    }
  }

  static Future<bool> handleStepCounterNotificationTack() async {
    PermissionStatus permissionStatus = await _getCheckNotificationPermStatus();
    if (permissionStatus != PermissionStatus.granted) {
      return false;
    }
    await _initializeLocalNotifications();
    await _showNotification(goal: 4, steps: 24);
    return true;
  }

  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/notification_icon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<PermissionStatus> _getCheckNotificationPermStatus() async {
    PermissionStatus status =
        await NotificationPermissions.getNotificationPermissionStatus();
    if (status != PermissionStatus.granted) {
      status = await _requestPermissions();
    }
    return status;
  }

  static Future<PermissionStatus> _requestPermissions() {
    return NotificationPermissions.requestNotificationPermissions();
  }

  static Future<void> _showNotification({
    required int goal,
    required int steps,
  }) {
    return _notificationsPlugin.show(
      Random().nextInt(100000),
      'You did $steps of $goal steps',
      'You still have time to achieve your goal',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'step_counter_channel_id',
          'step_counter_channel',
          channelDescription: 'Step Counter Channel',
          priority: Priority.high,
          importance: Importance.high,
        ),
      ),
    );
  }
}

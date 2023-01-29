import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:steps_counter/core/utils/work_manager_helper.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';

@LazySingleton()
class NotificationsHelper {
  static const String notificationPermissionNotGranted =
      'Notification permission not granted';

  NotificationsHelper(
    this._workManagerHelper,
    this._healthRepository,
    this._settingsRepository,
  );

  final WorkManagerHelper _workManagerHelper;
  final HealthRepository _healthRepository;
  final SettingsRepository _settingsRepository;

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<bool> initializeDailyNotification() async {
    PermissionStatus permissionStatus = await _getCheckNotificationPermStatus();
    if (permissionStatus != PermissionStatus.granted) {
      return false;
    }
    _workManagerHelper.initialize();
    return true;
  }

  Future<bool> handleStepCounterNotificationTack() async {
    PermissionStatus permissionStatus = await _getCheckNotificationPermStatus();
    if (permissionStatus != PermissionStatus.granted) {
      return false;
    }
    await _initializeLocalNotifications();
    final healthInfo = await _healthRepository.fetchHealthInfo();
    final currentSteps = healthInfo?.steps;
    if (currentSteps == null) {
      return false;
    }
    final goal = await _settingsRepository.fetchStepsGoal();
    if (currentSteps < goal) {
      await _showNotification(goal: goal, steps: currentSteps);
    }
    return true;
  }

  Future<void> _initializeLocalNotifications() async {
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

  Future<PermissionStatus> _getCheckNotificationPermStatus() async {
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

  Future<void> _showNotification({
    required int goal,
    required int steps,
  }) {
    return _notificationsPlugin.show(
      12514,
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

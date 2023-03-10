import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/notification_helper.dart';
import 'package:workmanager/workmanager.dart';

/// Enum for the different tasks handled by WorkManager.
enum WorkManagerTacks {
  /// Task for handling step counter notification.
  stepCounterNotification,
}

/// Entry point for callback dispatch from Workmanager.
@pragma('vm:entry-point')
void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await setupLocator();
    if (task == WorkManagerTacks.stepCounterNotification.name) {
      final notificationHelper = locator.get<NotificationsHelper>();
      return notificationHelper.handleStepCounterNotificationTask();
    }
    return false;
  });
}

/// Singleton class for managing work tasks using Workmanager.
@LazySingleton()
class WorkManagerHelper {
  /// Initializes [Workmanager] and sets up the periodic/one-off tasks.
  Future<void> initialize() async {
    try {
      final workManager = Workmanager();
      await workManager.initialize(_callbackDispatcher);
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

      /// at the moment, iOS doesn't allow periodic tasks
      if (Platform.isAndroid) {
        await workManager.registerPeriodicTask(
          'notification_periodic_step_count',
          WorkManagerTacks.stepCounterNotification.name,
          existingWorkPolicy: ExistingWorkPolicy.replace,
          frequency: const Duration(days: 1),
          initialDelay: initialDelay,
        );
      } else if (Platform.isIOS) {
        await workManager.registerOneOffTask(
          'notification_one_off_step_count',
          WorkManagerTacks.stepCounterNotification.name,
          existingWorkPolicy: ExistingWorkPolicy.replace,
          initialDelay: initialDelay,
        );
      }
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  }
}

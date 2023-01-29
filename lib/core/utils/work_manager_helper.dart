import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/notification_helper.dart';
import 'package:workmanager/workmanager.dart';

enum WorkManagerTacks {
  stepCounterNotification,
}

@pragma('vm:entry-point')
void _callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await setupLocator();
    if (task == WorkManagerTacks.stepCounterNotification.name) {
      final notificationHelper = locator.get<NotificationsHelper>();
      return notificationHelper.handleStepCounterNotificationTack();
    }
    return false;
  });
}

@LazySingleton()
class WorkManagerHelper {
  Future<void> initialize() async {
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
  }
}

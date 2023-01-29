

import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/notification_helper.dart';

class AppSetup {
  static Future<void> initialize() async {
    await setupLocator();
    locator.get<NotificationsHelper>().initialize();
  }
}
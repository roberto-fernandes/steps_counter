

import 'package:steps_counter/core/locator/locator.dart';

class AppSetup {
  static Future<void> initialize() async {
    await setupLocator();
  }
}
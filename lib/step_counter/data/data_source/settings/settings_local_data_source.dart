import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/step_counter/data/data_source/settings/settings_data_source.dart';

@LazySingleton()
class SettingsLocalDataSource extends SettingsDataSource {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<int?> fetchStepsGoal() async {
    final prefs = await _prefs;
    return prefs.getInt(PrefsKeys.stepGoals);
  }

  @override
  Future<bool?> fetchNotificationStatus() async {
    final prefs = await _prefs;
    return prefs.getBool(PrefsKeys.notificationStatus);
  }
}

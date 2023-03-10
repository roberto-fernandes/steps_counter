

import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/step_counter/data/data_source/settings/settings_data_source.dart';
import 'package:steps_counter/step_counter/data/data_source/settings/settings_local_data_source.dart';

class SettingsRepository extends BaseRepository<SettingsDataSource> {
  SettingsRepository({
    DataSourceType defaultDataSourceType = DataSourceType.local,
    SettingsDataSource? localDataSource,
    SettingsDataSource? mockDataSource,
  }) : super(
    localDataSource: localDataSource ?? locator.get<SettingsLocalDataSource>(),
    defaultDataSourceType: defaultDataSourceType,
    mockDataSource: mockDataSource,
  );

  Future<int> fetchStepsGoal() async {
    final data = await defaultDataSource?.fetchStepsGoal();
    return data ?? Defaults.stepsGoal;
  }

  Future<bool> setStepsGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(PrefsKeys.stepGoals, goal);
  }

  Future<bool> fetchNotificationsStatus() async {
    final data = await defaultDataSource?.fetchNotificationStatus();
    return data ?? false;
  }

  Future<bool> setNotificationsStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setBool(PrefsKeys.notificationStatus, status);
  }
}
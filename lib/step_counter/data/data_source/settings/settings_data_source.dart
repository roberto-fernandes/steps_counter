

abstract class SettingsDataSource{
  Future<int?> fetchStepsGoal();
  Future<bool?> fetchNotificationStatus();
}
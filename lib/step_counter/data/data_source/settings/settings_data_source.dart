
/// Abstract class for providing health data.
/// Must be extended from Settings DataSources
abstract class SettingsDataSource{
  Future<int?> fetchStepsGoal();
  Future<bool?> fetchNotificationStatus();
}
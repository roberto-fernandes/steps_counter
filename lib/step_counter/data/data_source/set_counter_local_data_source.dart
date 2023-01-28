import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/step_counter/data/data_source/step_counter_data_source.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton()
class StepCounterLocalDataSource extends StepCounterDataSource {
  final _prefs = SharedPreferences.getInstance();

  @override
  Future<int?> fetchStepsGoal() async {
    final prefs = await _prefs;
    return prefs.getInt(PrefsKeys.stepGoals);
  }

  @override
  Future<HealthInfo?> fetchHealthInfo() {
    throw UnimplementedError();
  }
}

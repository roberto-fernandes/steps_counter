import 'package:shared_preferences/shared_preferences.dart';
import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/step_counter/data/data_source/set_counter_local_data_source.dart';
import 'package:steps_counter/step_counter/data/data_source/step_counter_data_source.dart';
import 'package:steps_counter/step_counter/data/data_source/step_counter_mock_data_source.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

class StepCounterRepository extends BaseRepository<StepCounterDataSource> {
  StepCounterRepository({
    DataSourceType defaultDataSourceType = DataSourceType.mock,
  }) : super(
          mockDataSource: locator.get<StepCounterMockDataSource>(),
          localDataSource: locator.get<StepCounterLocalDataSource>(),
          defaultDataSourceType: defaultDataSourceType,
        );

  Future<HealthInfo?> fetchHealthInfo() async {
    final data = await defaultDataSource?.fetchHealthInfo();
    return data;
  }

  Future<int> fetchStepsGoal({bool useLocalDataSource = true}) async {
    final dataSource = useLocalDataSource ? localDataSource : defaultDataSource;
    final data = await dataSource?.fetchStepsGoal();
    return data ?? Defaults.stepsGoal;
  }

  Future<bool> setStepsGoal(int goal) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(PrefsKeys.stepGoals, goal);
  }
}

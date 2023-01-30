import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/step_counter/data/data_source/health/health_data_source.dart';
import 'package:steps_counter/step_counter/data/data_source/health/health_mock_data_source.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

class HealthRepository extends BaseRepository<HealthDataSource> {
  HealthRepository({
    DataSourceType defaultDataSourceType = DataSourceType.mock,
    HealthDataSource? mockDataSource,
  }) : super(
          mockDataSource: mockDataSource ?? locator.get<HealthMockDataSource>(),
          defaultDataSourceType: defaultDataSourceType,
        );

  Future<HealthInfo?> fetchHealthInfo() async {
    final data = await defaultDataSource?.fetchHealthInfo();
    return data;
  }
}

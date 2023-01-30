import 'package:flutter_test/flutter_test.dart';
import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/core/utils/utils.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_state.dart';
import 'package:steps_counter/step_counter/data/data_source/settings/settings_data_source.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';

void main() {
  group('SettingsBloc', () {
    final settingsRepository = SettingsRepository(
      defaultDataSourceType: DataSourceType.mock,
      mockDataSource: _SettingsTestDataSource(),
      localDataSource: _SettingsTestDataSource(),
    );
    final bloc = SettingsBloc(settingsRepository);

    test('initial state is correct', () {
      expect(bloc.state, const SettingsState(status: DataStatus.initial));
    });
  });
}

class _SettingsTestDataSource extends SettingsDataSource {
  @override
  Future<bool?> fetchNotificationStatus() async {
    await awaitDelay();
    return true;
  }

  @override
  Future<int?> fetchStepsGoal() async {
    await awaitDelay();
    return 5;
  }
}

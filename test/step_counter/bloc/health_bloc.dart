import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:steps_counter/core/data/base_repository.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/core/utils/utils.dart';
import 'package:steps_counter/step_counter/bloc/health/health_bloc.dart';
import 'package:steps_counter/step_counter/bloc/health/health_event.dart';
import 'package:steps_counter/step_counter/bloc/health/health_state.dart';
import 'package:steps_counter/step_counter/data/data_source/health/health_data_source.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';

void main() {
  group('HealthBloc', () {
    final healthRepository = HealthRepository(
      defaultDataSourceType: DataSourceType.mock,
      mockDataSource: _HealthTestDataSource(),
    );
    final bloc = HealthBloc(healthRepository);

    test('initial state is correct', () {
      expect(bloc.state, const HealthState(status: DataStatus.initial));
    });

    blocTest(
      'starts loading when started',
      build: () => bloc,
      act: (_) => bloc.add(StepCounterStarted()),
      expect: () => [const HealthState(status: DataStatus.loading)],
    );
  });
}

class _HealthTestDataSource extends HealthDataSource {
  @override
  Future<HealthInfo?> fetchHealthInfo() async {
    await awaitDelay();
    return const HealthInfo(steps: 12);
  }
}



import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/utils/utils.dart';
import 'package:steps_counter/step_counter/data/data_source/step_counter_data_source.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

@LazySingleton()
class StepCounterMockDataSource extends StepCounterDataSource {
  @override
  Future<HealthInfo?> fetchHealthInfo() async {
    await awaitDelay();
    final random = Random();
    return HealthInfo(steps: random.nextInt(1500), calories: random.nextInt(3000));
  }

  @override
  Future<int?> fetchStepsGoal() async {
    await awaitDelay();
    return 52;
  }
}
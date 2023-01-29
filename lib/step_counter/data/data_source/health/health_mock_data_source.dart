

import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:steps_counter/core/utils/utils.dart';
import 'package:steps_counter/step_counter/data/data_source/health/health_data_source.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

@LazySingleton()
class HealthMockDataSource extends HealthDataSource {
  @override
  Future<HealthInfo?> fetchHealthInfo() async {
    await awaitDelay();
    final randomSteps = Random().nextInt(1500);
    return HealthInfo(steps: randomSteps, calories: randomSteps * 2);
  }
}
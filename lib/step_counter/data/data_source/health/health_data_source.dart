
import 'package:steps_counter/step_counter/data/model/health_info.dart';

abstract class HealthDataSource{
  Future<HealthInfo?> fetchHealthInfo();
}
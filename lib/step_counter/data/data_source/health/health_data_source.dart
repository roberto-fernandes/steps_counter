
import 'package:steps_counter/step_counter/data/model/health_info.dart';

/// Abstract class for providing health data.
/// Must be extended from Heath DataSources
abstract class HealthDataSource{
  Future<HealthInfo?> fetchHealthInfo();
}
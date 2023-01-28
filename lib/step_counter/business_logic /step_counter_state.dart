import 'package:equatable/equatable.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

class StepCounterState extends Equatable {
  const StepCounterState({
    this.status = DataStatus.initial,
    this.healthInfo,
    this.error,
  });

  final DataStatus status;
  final HealthInfo? healthInfo;
  final String? error;

  @override
  List<Object?> get props => [status, healthInfo];
}

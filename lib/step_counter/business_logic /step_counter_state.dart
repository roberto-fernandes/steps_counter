import 'package:equatable/equatable.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

class StepCounterState extends Equatable {
  const StepCounterState({
    this.status = DataStatus.initial,
    this.goal,
    this.healthInfo,
    this.error,
  });

  final DataStatus status;
  final int? goal;
  final HealthInfo? healthInfo;
  final String? error;

  @override
  List<Object?> get props => [status, goal, healthInfo, error];

  StepCounterState copyWith({
    DataStatus? status,
    int? goal,
    HealthInfo? healthInfo,
    String? error,
  }) {
    return StepCounterState(
      status: status ?? this.status,
      goal: goal ?? this.goal,
      healthInfo: healthInfo ?? this.healthInfo,
      error: error ?? this.error,
    );
  }
}

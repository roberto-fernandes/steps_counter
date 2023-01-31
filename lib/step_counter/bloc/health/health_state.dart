import 'package:equatable/equatable.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

/// HealthState represents the state of a [HealthBloc].
/// It's used single class approach for simplicity reasons,
/// It can be be change to multiple classes if state increases in complexity
class HealthState extends Equatable {
  const HealthState({
    this.status = DataStatus.initial,
    this.healthInfo,
    this.error,
  });

  /// Represents the status of the data being fetched.
  final DataStatus status;
  /// The health information retrieved.
  final HealthInfo? healthInfo;
  /// The error message, if any, that occurred while fetching data.
  final String? error;

  @override
  List<Object?> get props => [status, healthInfo, error];

  /// Creates a new instance of [HealthState] with the provided parameters.
  /// Any parameter that is not provided will use the value from the current instance.
  HealthState copyWith({
    DataStatus? status,
    HealthInfo? healthInfo,
    String? error,
  }) {
    return HealthState(
      status: status ?? this.status,
      healthInfo: healthInfo ?? this.healthInfo,
      error: error ?? this.error,
    );
  }
}

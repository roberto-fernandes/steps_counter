import 'package:equatable/equatable.dart';
import 'package:steps_counter/core/data/data_status.dart';

/// HealthState represents the state of a [HealthBloc].
/// It's used single class approach for simplicity reasons,
/// It can be be change to multiple classes if state increases in complexity
class SettingsState extends Equatable {
  const SettingsState({
    this.status = DataStatus.initial,
    this.notificationStatus = false,
    this.stepsGoal,
    this.error,
  });

  /// Represents the status of the data being fetched.
  final DataStatus status;
  final int? stepsGoal;
  final bool notificationStatus;
  /// The error message, if any, that occurred while fetching data.
  final String? error;

  @override
  List<Object?> get props => [status, stepsGoal, notificationStatus, error];

  /// Creates a new instance of [SettingsState] with the provided parameters.
  /// Any parameter that is not provided will use the value from the current instance.
  SettingsState copyWith({
    DataStatus? status,
    int? stepsGoal,
    bool? notificationStatus,
    String? error,
  }) {
    return SettingsState(
      status: status ?? this.status,
      stepsGoal: stepsGoal ?? this.stepsGoal,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      error: error ?? this.error,
    );
  }
}

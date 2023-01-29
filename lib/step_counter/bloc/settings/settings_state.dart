import 'package:equatable/equatable.dart';
import 'package:steps_counter/core/data/data_status.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.status = DataStatus.initial,
    this.notificationStatus = false,
    this.stepsGoal,
    this.error,
  });

  final DataStatus status;
  final int? stepsGoal;
  final bool notificationStatus;
  final String? error;

  @override
  List<Object?> get props => [status, stepsGoal, notificationStatus, error];

  SettingsState copyWith({
    DataStatus? status,
    int? goal,
    bool? notificationStatus,
    String? error,
  }) {
    return SettingsState(
      status: status ?? this.status,
      stepsGoal: goal ?? this.stepsGoal,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      error: error ?? this.error,
    );
  }
}

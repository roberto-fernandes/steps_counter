import 'package:equatable/equatable.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.status = DataStatus.initial,
    this.notificationStatus = false,
    this.goal,
    this.error,
  });

  final DataStatus status;
  final int? goal;
  final bool notificationStatus;
  final String? error;

  @override
  List<Object?> get props => [status, goal, notificationStatus, error];

  SettingsState copyWith({
    DataStatus? status,
    int? goal,
    bool? notificationStatus,
    String? error,
  }) {
    return SettingsState(
      status: status ?? this.status,
      goal: goal ?? this.goal,
      notificationStatus: notificationStatus ?? this.notificationStatus,
      error: error ?? this.error,
    );
  }
}

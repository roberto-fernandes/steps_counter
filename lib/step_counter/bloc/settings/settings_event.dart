import 'package:equatable/equatable.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SettingsStarted extends SettingsEvent {}

class StepGoalSet extends SettingsEvent {
  StepGoalSet(this.goal);

  final int goal;

  @override
  List<Object?> get props => [goal];
}

class NotificationTogged extends SettingsEvent {}

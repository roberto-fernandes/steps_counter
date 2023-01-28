
import 'package:equatable/equatable.dart';

abstract class StepCounterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepCounterStarted extends StepCounterEvent {}

class StepGoalSet extends StepCounterEvent {
  StepGoalSet(this.goal);

  final int goal;

  @override
  List<Object?> get props => [goal];
}
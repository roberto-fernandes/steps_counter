
import 'package:equatable/equatable.dart';

/// [HealthEvent] is an abstract base class for health events.
abstract class HealthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepCounterStarted extends HealthEvent {}
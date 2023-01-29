
import 'package:equatable/equatable.dart';

abstract class HealthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StepCounterStarted extends HealthEvent {}
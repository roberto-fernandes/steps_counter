import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/business_logic%20/step_counter_event.dart';
import 'package:steps_counter/step_counter/business_logic%20/step_counter_state.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';
import 'package:steps_counter/step_counter/data/repository/step_counter_repository.dart';

class StepCounterBloc extends Bloc<StepCounterEvent, StepCounterState> {
  StepCounterBloc(
    this._stepCounterRepository,
  ) : super(const StepCounterState()) {
    on<StepCounterStarted>(_onStarted);
    on<StepGoalSet>(_onStepGoalSet);
  }

  final StepCounterRepository _stepCounterRepository;

  Future<void> _onStarted(
    StepCounterEvent event,
    Emitter<StepCounterState> emit,
  ) async {
    _emitLoadingState(emit);
    try {
      final data = await Future.wait([
        _stepCounterRepository.fetchHealthInfo(),
        _stepCounterRepository.fetchStepsGoal(),
      ]);
      final healthInfo = data[0] as HealthInfo?;
      final stepsGoal = data[1] as int;

      emit(
        state.copyWith(
          status: DataStatus.success,
          healthInfo: healthInfo,
          goal: stepsGoal,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: DataStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onStepGoalSet(
    StepGoalSet event,
    Emitter<StepCounterState> emit,
  ) async {
    _stepCounterRepository.setStepsGoal(event.goal);
    emit(
      state.copyWith(
        goal: event.goal,
      ),
    );
  }

  void _emitLoadingState(Emitter<StepCounterState> emit) {
    emit(state.copyWith(status: DataStatus.loading));
  }
}

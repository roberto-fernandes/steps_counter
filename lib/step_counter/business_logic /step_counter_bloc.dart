import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/business_logic%20/step_counter_event.dart';
import 'package:steps_counter/step_counter/business_logic%20/step_counter_state.dart';
import 'package:steps_counter/step_counter/data/model/health_info.dart';

class StepCounterBloc extends Bloc<StepCounterEvent, StepCounterState> {
  
  StepCounterBloc() : super(const StepCounterState()) {
    on<StepCounterStarted>(_onStarted);
  }

  Future<void> _onStarted(
    StepCounterEvent event,
    Emitter<StepCounterState> emit,
  ) async {
    emit(const StepCounterState(status: DataStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final data = HealthInfo(steps: 5, calories: 12);
      emit(
        StepCounterState(
          status: DataStatus.success,
          healthInfo: data,
        ),
      );
    } catch (error) {
      emit(
        StepCounterState(
          status: DataStatus.failure,
          error: error.toString(),
        ),
      );
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/bloc/health/health_event.dart';
import 'package:steps_counter/step_counter/bloc/health/health_state.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';

/// Handles he events related to Health information
/// and updates the state accordingly.
class HealthBloc extends Bloc<HealthEvent, HealthState> {
  HealthBloc(
    this._healthRepository,
  ) : super(const HealthState()) {
    on<StepCounterStarted>(_onStarted);
  }

  final HealthRepository _healthRepository;

  Future<void> _onStarted(
    HealthEvent event,
    Emitter<HealthState> emit,
  ) async {
    emit(state.copyWith(status: DataStatus.loading));
    try {
      final healthInfo = await _healthRepository.fetchHealthInfo();
      emit(
        state.copyWith(
          status: DataStatus.success,
          healthInfo: healthInfo,
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
}

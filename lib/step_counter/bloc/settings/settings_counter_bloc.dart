import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/notification_helper.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_event.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_state.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    this._settingsRepository,
  ) : super(const SettingsState()) {
    on<SettingsStarted>(_onStarted);
    on<StepGoalSet>(_onStepGoalSet);
    on<NotificationTogged>(_onNotificationToggled);
  }

  final SettingsRepository _settingsRepository;

  Future<void> _onStarted(
    SettingsStarted event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      final data = await Future.wait([
        _settingsRepository.fetchNotificationsStatus(),
        _settingsRepository.fetchStepsGoal(),
      ]);
      final notificationStatus = data[0] as bool;
      final stepsGoal = data[1] as int;

      emit(
        state.copyWith(
          status: DataStatus.success,
          goal: stepsGoal,
          error: null,
          notificationStatus: notificationStatus,
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
    Emitter<SettingsState> emit,
  ) async {
    _settingsRepository.setStepsGoal(event.goal);
    emit(
      state.copyWith(
        status: DataStatus.success,
        error: null,
        goal: event.goal,
      ),
    );
  }

  Future<void> _onNotificationToggled(
    NotificationTogged event,
    Emitter<SettingsState> emit,
  ) async {
    final isNotificationsOn = !state.notificationStatus;
    if (isNotificationsOn) {
      final hasPermissions = await _initializeDailyNotification();
      if(!hasPermissions) {
        return;
      }
    }
    _settingsRepository.setNotificationsStatus(isNotificationsOn);
    emit(
      state.copyWith(
        status: DataStatus.success,
        error: null,
        notificationStatus: isNotificationsOn,
      ),
    );
  }

  Future<bool> _initializeDailyNotification() async {
    final notificationHelper = locator.get<NotificationsHelper>();
    return notificationHelper.initializeDailyNotification();
  }
}

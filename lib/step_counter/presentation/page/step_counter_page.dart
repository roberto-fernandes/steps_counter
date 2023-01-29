import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/step_counter/bloc/health/health_bloc.dart';
import 'package:steps_counter/step_counter/bloc/health/health_event.dart';
import 'package:steps_counter/step_counter/bloc/health/health_state.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_event.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_state.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';
import 'package:steps_counter/step_counter/presentation/widget/edit_step_goal_widget.dart';
import 'package:steps_counter/step_counter/presentation/widget/notification_widget.dart';

class StepCounterPage extends StatelessWidget {
  const StepCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => locator.get<HealthRepository>()),
        RepositoryProvider(
            create: (context) => locator.get<SettingsRepository>()),
      ],
      child: const _StepCounterView(),
    );
  }
}

class _StepCounterView extends StatelessWidget {
  const _StepCounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HealthBloc(
            RepositoryProvider.of<HealthRepository>(context),
          )..add(StepCounterStarted()),
        ),
        BlocProvider(
          create: (_) => SettingsBloc(
            RepositoryProvider.of<SettingsRepository>(context),
          )..add(SettingsStarted()),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (
          context,
          settingsState,
        ) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Placeholder'),
              actions: const [
                NotificationWidget(),
              ],
            ),
            body: Center(
              child: BlocBuilder<HealthBloc, HealthState>(
                builder: (
                  context,
                  healthState,
                ) {
                  switch (healthState.status) {
                    case DataStatus.initial:
                      return const SizedBox();
                    case DataStatus.loading:
                      return const CircularProgressIndicator();
                    case DataStatus.success:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Steps: ${healthState.healthInfo?.steps}'),
                          Text('Calories: ${healthState.healthInfo?.calories}'),
                          Text('Goal: ${settingsState.goal}'),
                          const EditStepGoalWidget(),
                        ],
                      );
                    case DataStatus.failure:
                      return const Text('Failure to load data');
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/core/locator/locator.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/step_counter/bloc/health/health_bloc.dart';
import 'package:steps_counter/step_counter/bloc/health/health_event.dart';
import 'package:steps_counter/step_counter/bloc/health/health_state.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_event.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_state.dart';
import 'package:steps_counter/step_counter/data/repository/health_repository.dart';
import 'package:steps_counter/step_counter/data/repository/settings_repository.dart';
import 'package:steps_counter/step_counter/presentation/widget/circular_indicator.dart';
import 'package:steps_counter/step_counter/presentation/widget/edit_step_goal_widget.dart';
import 'package:steps_counter/step_counter/presentation/widget/information_row_widget.dart';
import 'package:steps_counter/step_counter/presentation/widget/liner_indicator.dart';
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
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: const [
            NotificationWidget(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stepcounter',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 70),
                const _StepCounterContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepCounterContent extends StatelessWidget {
  const _StepCounterContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HealthBloc, HealthState>(
      builder: (
        context,
        healthState,
      ) {
        switch (healthState.status) {
          case DataStatus.initial:
            return const SizedBox();
          case DataStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case DataStatus.success:
            return BlocBuilder<SettingsBloc, SettingsState>(builder: (
              context,
              settingsState,
            ) {
              final currentSteps = healthState.healthInfo?.steps;
              final stepsGoal = settingsState.stepsGoal;
              final double? stepsPercentage = _percentage(
                currentSteps,
                stepsGoal,
              );

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (stepsPercentage != null)
                    CircularIndicator(
                      percentage: stepsPercentage,
                    ),
                  InformationRowWidget(
                    stepsGoal: stepsGoal,
                    currentSteps: currentSteps,
                  ),
                  EditStepGoalWidget(
                    initialGoal: stepsGoal ?? Defaults.stepsGoal,
                  ),
                  if (stepsPercentage != null)
                    LinearIndicator(
                      percentage: stepsPercentage,
                    ),
                ],
              );
            });
          case DataStatus.failure:
            return const Text('Failure to load data');
        }
      },
    );
  }

  double? _percentage(int? current, int? goal) {
    double? stepsPercentage;
    if ((current ?? 0) > 0 && (goal ?? 0) > 0) {
      stepsPercentage = current! / goal! * 100;
    }
    return stepsPercentage;
  }
}

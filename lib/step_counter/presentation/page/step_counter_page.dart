import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/data/data_status.dart';
import 'package:steps_counter/step_counter/bloc/step_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/step_counter_event.dart';
import 'package:steps_counter/step_counter/bloc/step_counter_state.dart';
import 'package:steps_counter/step_counter/data/repository/step_counter_repository.dart';
import 'package:steps_counter/step_counter/presentation/widget/edit_step_goal_widget.dart';

class StepCounterPage extends StatelessWidget {
  const StepCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => StepCounterRepository(),
      child: const _StepCounterView(),
    );
  }
}

class _StepCounterView extends StatelessWidget {
  const _StepCounterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StepCounterBloc(
        RepositoryProvider.of<StepCounterRepository>(context),
      )..add(StepCounterStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Placeholder'),
        ),
        body: Center(
          child: BlocBuilder<StepCounterBloc, StepCounterState>(builder: (
            context,
            state,
          ) {
            switch (state.status) {
              case DataStatus.initial:
                return const SizedBox();
              case DataStatus.loading:
                return const CircularProgressIndicator();
              case DataStatus.success:
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Steps: ${state.healthInfo?.steps}'),
                    Text('Calories: ${state.healthInfo?.calories}'),
                    Text('Goal: ${state.goal}'),
                    const EditStepGoalWidget(),
                  ],
                );
              case DataStatus.failure:
                return const Text('Failure to load data');
            }
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/core/utils/constants.dart';
import 'package:steps_counter/step_counter/bloc/step_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/step_counter_event.dart';

class EditStepGoalWidget extends StatefulWidget {
  const EditStepGoalWidget({
    super.key,
  });

  @override
  State<EditStepGoalWidget> createState() => _EditStepGoalWidgetState();
}

class _EditStepGoalWidgetState extends State<EditStepGoalWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final state = context.watch<StepCounterBloc>().state;
      return ElevatedButton(
        onPressed: () => _showSetGoalDialog(
          context: context,
          initialGoal: state.goal ?? Defaults.stepsGoal,
          onGoalSelected: (int goal) {
            context.read<StepCounterBloc>().add(StepGoalSet(goal));
          },
        ),
        child: const Text('Set Goal'),
      );
    });
  }

  Future _showSetGoalDialog({
    required BuildContext context,
    required int initialGoal,
    required void Function(int goal) onGoalSelected,
  }) {
    return showDialog(
      context: context,
      builder: (innerContext) {
        return AlertDialog(
          title: const Text('Set your Steps Goal'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                try {
                  final input = _controller.text.toString();
                  final goal = int.parse(input);
                  onGoalSelected(goal);
                } catch (error) {
                  if (kDebugMode) {
                    print(error);
                  }
                }
                Navigator.pop(innerContext);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }
}

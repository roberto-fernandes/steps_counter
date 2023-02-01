import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_counter_bloc.dart';
import 'package:steps_counter/step_counter/bloc/settings/settings_event.dart';

class EditStepGoalWidget extends StatefulWidget {
  const EditStepGoalWidget({
    required this.initialGoal,
    super.key,
  });

  final int initialGoal;

  @override
  State<EditStepGoalWidget> createState() => _EditStepGoalWidgetState();
}

class _EditStepGoalWidgetState extends State<EditStepGoalWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = '${widget.initialGoal}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextButton.icon(
        onPressed: () => _showSetGoalDialog(
          context: context,
          initialGoal: widget.initialGoal,
          onGoalSelected: (int goal) {
            context.read<SettingsBloc>().add(StepGoalSet(goal));
          },
        ),
        icon: const Icon(
          Icons.edit,
          size: 14,
        ),
        label: const Text('Daily Goal'),
      ),
    );
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
                  if (input.isNotEmpty) {
                    final goal = int.parse(input);
                    onGoalSelected(goal);
                  }
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

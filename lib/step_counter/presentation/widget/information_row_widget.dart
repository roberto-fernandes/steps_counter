import 'package:flutter/material.dart';
import 'package:steps_counter/core/utils/constants.dart';

class InformationRowWidget extends StatelessWidget {
  const InformationRowWidget({
    this.stepsGoal,
    this.currentSteps,
    Key? key,
  }) : super(key: key);

  final int? stepsGoal;
  final int? currentSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InformationItem(
            icon: const Icon(Icons.add),
            goal: stepsGoal,
            description: 'Steps',
            current: currentSteps,
          ),
          _InformationItem(
            icon: const Icon(Icons.add),
            description: 'Calories',
            current: currentSteps != null
                ? currentSteps! * Defaults.caloriesPerStep
                : null,
            goal: stepsGoal != null
                ? stepsGoal! * Defaults.caloriesPerStep
                : null,
          ),
        ],
      ),
    );
  }
}

class _InformationItem extends StatelessWidget {
  const _InformationItem({
    required this.icon,
    required this.current,
    required this.goal,
    required this.description,
    Key? key,
  }) : super(key: key);

  final Widget icon;
  final int? current;
  final int? goal;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(
          '${current ?? '-'}/${goal ?? '-'}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

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
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _InformationItem(
            icon: Image.asset(Assets.steps),
            goal: stepsGoal,
            description: 'Steps',
            current: currentSteps,
          ),
          _InformationItem(
            icon: Image.asset(Assets.flame),
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
        const SizedBox(height: 8),
        Text(
          '${current ?? '-'}/${goal ?? '-'}',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

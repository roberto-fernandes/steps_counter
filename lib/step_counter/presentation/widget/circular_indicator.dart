import 'dart:math';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    required this.percentage,
    Key? key,
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: CircularPercentIndicator(
        radius: 100.0,
        lineWidth: 8.0,
        animation: true,
        percent: min(percentage / 100, 1.0),
        center: Text(
          "${percentage.toInt()}%",
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 45,
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colorScheme.primary,
      ),
    );
  }
}

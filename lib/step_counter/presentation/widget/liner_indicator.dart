import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LinearIndicator extends StatelessWidget {
  const LinearIndicator({
    required this.percentage,
    Key? key,
  }) : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: const Icon(
                Icons.flag,
                size: 16,
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return LinearPercentIndicator(
                width: constraints.maxWidth,
                animation: true,
                lineHeight: 8.0,
                animationDuration: 400,
                percent: min(percentage / 100, 1.0),
                barRadius: const Radius.circular(16),
                progressColor: Theme.of(context).colorScheme.primary,
              );
            },
          ),
        ],
      ),
    );
  }
}

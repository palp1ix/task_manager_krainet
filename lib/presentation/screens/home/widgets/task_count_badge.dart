import 'package:flutter/material.dart';

class TaskCountBadge extends StatelessWidget {
  const TaskCountBadge(
    this.taskCount, {
    super.key,
  });

  final int taskCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        width: 36,
        height: 22,
        decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(5)),
        child: Center(
            child: Text(
          '$taskCount',
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 12),
        )));
  }
}

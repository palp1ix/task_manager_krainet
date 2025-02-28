import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_krainet/presentation/screens/home/widgets/task_count_badge.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.taskCount,
    required this.onTap,
  });

  final String title;
  final String iconPath;
  final int taskCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: 27),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                  theme.colorScheme.onSurface, BlendMode.srcIn),
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
            ),
            Spacer(),
            TaskCountBadge(taskCount),
          ],
        ),
      ),
    );
  }
}

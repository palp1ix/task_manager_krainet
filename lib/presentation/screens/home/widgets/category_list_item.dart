import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_krainet/core/utils/utils.dart';
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
    final isBigScreen = AppUtils.isBigScreen(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: isBigScreen
            ? EdgeInsets.all(10)
            : EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: isBigScreen ? 16 : 8,
        ),
        decoration: isBigScreen
            ? BoxDecoration(
                color: theme.colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: isBigScreen
            ? _buildBigScreenLayout(theme)
            : _buildSmallScreenLayout(theme),
      ),
    );
  }

  Widget _buildSmallScreenLayout(ThemeData theme) {
    return Row(
      children: [
        SvgPicture.asset(
          iconPath,
          width: 24,
          height: 24,
          colorFilter:
              ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
        ),
        SizedBox(width: 20),
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
        ),
        Spacer(),
        TaskCountBadge(taskCount),
      ],
    );
  }

  Widget _buildBigScreenLayout(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 32,
          height: 32,
          colorFilter:
              ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
        ),
        SizedBox(height: 12),
        Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        TaskCountBadge(taskCount),
      ],
    );
  }
}

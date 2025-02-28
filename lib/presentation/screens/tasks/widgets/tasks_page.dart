import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryName;

    categoryName = Provider.of<String>(context);

    final theme = Theme.of(context);

    return SafeArea(
        child: Column(
      children: [
        SizedBox(height: AppConstants.topInset),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(categoryName,
                  style: theme.textTheme.bodyLarge?.copyWith(fontSize: 24)),
              Spacer(),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/plus.svg',
                  // White color constantly in both themes
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: 30,
                  height: 30,
                ),
                style: IconButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                ),
                onPressed: () {
                  context.router.push(AddTaskRoute());
                },
              )
            ],
          ),
        )
      ],
    ));
  }
}

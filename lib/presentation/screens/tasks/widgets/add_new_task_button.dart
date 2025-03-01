import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/bloc/task_bloc.dart';

class AddNewTaskButton extends StatelessWidget {
  const AddNewTaskButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryName = context.watch<String>();
    final theme = Theme.of(context);

    return IconButton(
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
        context.router.push(AddTaskRoute(categoryName: categoryName));
      },
    );
  }
}

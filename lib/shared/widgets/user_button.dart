import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';

class UserButton extends StatelessWidget {
  const UserButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      icon: SvgPicture.asset(
        'assets/icons/user.svg',
        width: 24,
        height: 24,
        colorFilter:
            ColorFilter.mode(theme.colorScheme.onSurface, BlendMode.srcIn),
      ),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      style: IconButton.styleFrom(
          backgroundColor: theme.colorScheme.surfaceContainer,
          padding: EdgeInsets.all(10)),
      onPressed: () {
        context.router.push(ProfileRoute());
      },
    );
  }
}

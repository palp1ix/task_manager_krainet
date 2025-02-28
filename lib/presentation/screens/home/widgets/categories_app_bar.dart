import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/widgets/user_button.dart';

class CategoriesAppBar extends StatelessWidget {
  const CategoriesAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Logo
          SvgPicture.asset('assets/icons/logo.svg'),

          SizedBox(width: 10),

          // 2 Text labels
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                localization.appTitle,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(fontSize: 24, color: theme.primaryColor),
              ),
              Text(
                localization.subName,
                style: theme.textTheme.bodyLarge?.copyWith(fontSize: 12),
              ),
            ],
          ),

          Spacer(),

          // User profile button
          UserButton(),
        ],
      ),
    );
  }
}

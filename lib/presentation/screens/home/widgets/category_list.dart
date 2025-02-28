import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:task_manager_krainet/presentation/screens/home/widgets/category_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    // List of categories items, it's here, because no need
    // for receiving it from backend, it's constants
    final categiriesItemsList = [
      {
        'name': localization.categoryItemAll,
        'iconPath': 'assets/icons/application.svg'
      },
      {
        'name': localization.categoryItemToday,
        'iconPath': 'assets/icons/today.svg'
      },
      {
        'name': localization.categoryItemWork,
        'iconPath': 'assets/icons/work.svg'
      },
      {
        'name': localization.categoryItemPersonal,
        'iconPath': 'assets/icons/personal.svg'
      },
      {
        'name': localization.categoryItemCompleted,
        'iconPath': 'assets/icons/check.svg'
      },
    ];

    return Expanded(
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: categiriesItemsList.length,
          itemBuilder: (context, index) {
            final title = categiriesItemsList[index]['name']!;
            final iconPath = categiriesItemsList[index]['iconPath']!;

            return CategoryListItem(
              title: title,
              iconPath: iconPath,
              taskCount: 4,
              onTap: () {
                context.router.push(TasksScreenRoute(categoryName: title));
              },
            );
          }),
    );
  }
}

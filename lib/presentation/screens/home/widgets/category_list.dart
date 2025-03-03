import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:task_manager_krainet/core/utils/utils.dart';
import 'package:task_manager_krainet/domain/entities/task_category.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/home/task_count/task_count_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/home/task_count/task_count_event.dart';
import 'package:task_manager_krainet/presentation/screens/home/task_count/task_count_state.dart';
import 'package:task_manager_krainet/presentation/screens/home/widgets/category_list_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/presentation/screens/task_details/bloc/task_details_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/bloc/task_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  /// TaskCountBloc instance retrieved from the DI
  late final TaskCountBloc _taskCountBloc;

  @override
  void initState() {
    super.initState();

    // Get the bloc from the service locator
    _taskCountBloc = context.read<TaskCountBloc>();

    // Load task counts for all categories when the widget initializes
    _taskCountBloc.add(const LoadTaskCounts());
  }

  /// Maps localized category name to TaskCategory enum
  TaskCategory _getCategoryFromName(
      String name, AppLocalizations localization) {
    if (name == localization.categoryItemAll) {
      return TaskCategory.all;
    } else if (name == localization.categoryItemToday) {
      return TaskCategory.today;
    } else if (name == localization.categoryItemWork) {
      return TaskCategory.work;
    } else if (name == localization.categoryItemPersonal) {
      return TaskCategory.personal;
    } else if (name == localization.categoryItemCompleted) {
      return TaskCategory.completed;
    }
    return TaskCategory.other;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final isBigScreen = AppUtils.isBigScreen(context);

    // List of categories items, it's here, because no need
    // for receiving it from backend, it's constants
    final categoriesItemsList = [
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
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddTaskBloc, AddTaskState>(
            listener: (context, state) {
              if (state is AddTaskSuccess) {
                // Load task counts for all categories when the widget initializes
                _taskCountBloc.add(const LoadTaskCounts());
              }
            },
          ),
          BlocListener<TaskDetailsBloc, TaskDetailsState>(
            listener: (context, state) {
              if (state is TaskDetailsSuccess) {
                // Load task counts for all categories when the widget initializes
                _taskCountBloc.add(const LoadTaskCounts());
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is TaskSuccess) {
                // Load task counts for all categories when the widget initializes
                _taskCountBloc.add(const LoadTaskCounts());
              }
            },
          ),
        ],
        child: BlocBuilder<TaskCountBloc, TaskCountState>(
          bloc: _taskCountBloc,
          builder: (context, state) {
            return isBigScreen
                ? _buildBigScreen(categoriesItemsList, localization, state)
                : _buildSmallScreen(categoriesItemsList, localization, state);
          },
        ),
      ),
    );
  }

  Widget _buildSmallScreen(List<Map<String, String>> categoriesItemsList,
      AppLocalizations localization, TaskCountState state) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categoriesItemsList.length,
      itemBuilder: (context, index) {
        final title = categoriesItemsList[index]['name']!;
        final iconPath = categoriesItemsList[index]['iconPath']!;
        final category = _getCategoryFromName(title, localization);

        // Determine task count based on the current state
        int taskCount = 0;
        if (state is TaskCountLoaded) {
          taskCount = state.categoryCounts[category] ?? 0;
        }

        return CategoryListItem(
          title: title,
          iconPath: iconPath,
          taskCount: taskCount,
          onTap: () {
            context.router.push(TasksScreenRoute(categoryName: title));
          },
        );
      },
    );
  }

  Widget _buildBigScreen(List<Map<String, String>> categoriesItemsList,
      AppLocalizations localization, TaskCountState state) {
    // Calculate number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final columnCount = (screenWidth / AppConstants.columnWidthPixels).ceil();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columnCount <= categoriesItemsList.length
              ? columnCount
              : categoriesItemsList.length,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoriesItemsList.length,
        itemBuilder: (context, index) {
          final title = categoriesItemsList[index]['name']!;
          final iconPath = categoriesItemsList[index]['iconPath']!;
          final category = _getCategoryFromName(title, localization);

          // Determine task count based on the current state
          int taskCount = 0;
          if (state is TaskCountLoaded) {
            taskCount = state.categoryCounts[category] ?? 0;
          }

          return CategoryListItem(
            title: title,
            iconPath: iconPath,
            taskCount: taskCount,
            onTap: () {
              context.router.push(TasksScreenRoute(categoryName: title));
            },
          );
        },
      ),
    );
  }
}

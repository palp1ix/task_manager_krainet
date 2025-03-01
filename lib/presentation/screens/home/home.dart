import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/presentation/screens/home/widgets/categories_app_bar.dart';
import 'package:task_manager_krainet/presentation/screens/home/widgets/category_list.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(height: AppConstants.topInset),

          CategoriesAppBar(), // This app bar is just a row

          SizedBox(height: 30),

          CategoriesList(), // List of categories
        ],
      ),
    ));
  }
}

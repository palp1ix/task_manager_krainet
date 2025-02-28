import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_krainet/presentation/screens/home/widgets/categories.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CategoriesPage());
  }
}

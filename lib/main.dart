import 'package:flutter/material.dart';
import 'package:task_manager_krainet/shared/theme.dart';
import 'package:task_manager_krainet/core/router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  // Initialize our router
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // configure routes from router
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false);
  }
}

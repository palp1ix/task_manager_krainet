import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager_krainet/core/blocs/auth/auth_bloc.dart';
import 'package:task_manager_krainet/init_dependencies.dart';
import 'package:task_manager_krainet/presentation/screens/add_task/bloc/add_task_bloc.dart';
import 'package:task_manager_krainet/presentation/screens/tasks/bloc/task_bloc.dart';
import 'package:task_manager_krainet/shared/theme/theme.dart';
import 'package:task_manager_krainet/core/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // Provide all our blocs
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (_) => serviceLocator<AuthBloc>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<AddTaskBloc>(),
    ),
    BlocProvider(
      create: (_) => serviceLocator<TaskBloc>(),
    ),
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  // Initialize router
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Push user device info to bottom widget tree for responsible in all widgets
    return MaterialApp.router(

        // Setup multiple languages
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,

        // Setup theme system adaptive
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,

        // configure routes from router
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false);
  }
}

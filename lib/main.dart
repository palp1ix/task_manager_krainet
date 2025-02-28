import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:task_manager_krainet/firebase_options.dart';
import 'package:task_manager_krainet/shared/theme/theme.dart';
import 'package:task_manager_krainet/core/router/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
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

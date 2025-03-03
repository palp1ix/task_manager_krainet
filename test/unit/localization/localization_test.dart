import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  group('Localization Tests', () {
    // Helper function to build localized app with given locale
    Widget createLocalizedApp(Locale locale) {
      return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: Builder(
          builder: (context) {
            final localizations = AppLocalizations.of(context)!;
            // Return a widget that displays localized strings
            return Scaffold(
              body: ListView(
                children: [
                  // Display common localized strings for testing
                  Text(localizations.appTitle),
                  // Add more localized strings as needed
                  // Text(localizations.loginButtonText),
                  // Text(localizations.taskListTitle),
                ],
              ),
            );
          },
        ),
      );
    }

    testWidgets('English localization test', (WidgetTester tester) async {
      await tester.pumpWidget(createLocalizedApp(const Locale('en')));
      await tester.pumpAndSettle();

      // Verify English strings are displayed correctly
      expect(find.text('Task Manager'), findsOneWidget); // Assuming 'Task Manager' is the app title in English
      // Add more expect statements for other strings
      // expect(find.text('Login'), findsOneWidget);
      // expect(find.text('Tasks'), findsOneWidget);
    });

    testWidgets('Russian localization test', (WidgetTester tester) async {
      await tester.pumpWidget(createLocalizedApp(const Locale('ru')));
      await tester.pumpAndSettle();

      // Verify Russian strings are displayed correctly
      expect(find.text('Менеджер задач'), findsOneWidget); // Assuming 'Менеджер задач' is the app title in Russian
      // Add more expect statements for other strings
      // expect(find.text('Войти'), findsOneWidget);
      // expect(find.text('Задачи'), findsOneWidget);
    });

    // Add more tests for other supported locales if needed
  });

  group('Locale Detection and Override Tests', () {
    testWidgets('Use device locale when available', (WidgetTester tester) async {
      // This test verifies that the app uses the device locale when it's supported
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          // No explicit locale set, should use device locale
          home: Builder(
            builder: (context) {
              final localizations = AppLocalizations.of(context)!;
              return Text(localizations.appTitle);
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
      
      // The test environment default locale is English, so we expect English strings
      expect(find.text('Task Manager'), findsOneWidget);
    });
  });
}
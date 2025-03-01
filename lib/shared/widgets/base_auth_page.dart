import 'package:flutter/material.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_button.dart';
import 'package:task_manager_krainet/shared/widgets/tap_outside_to_unfocus.dart';

/// A base widget for authentication screens (login and signup) that provides
/// common UI structure and functionality.
///
/// This widget encapsulates the shared layout, styling, and behavior of authentication
/// screens, reducing code duplication and improving maintainability.
class BaseAuthPage extends StatelessWidget {
  /// Form key for the authentication form.
  final GlobalKey<FormState> formKey;

  /// Title displayed at the top of the screen.
  final String title;

  /// Subtitle displayed below the title.
  final String subtitle;

  /// Primary button text.
  final String primaryButtonText;

  /// Callback function when the primary button is pressed.
  final VoidCallback onPrimaryButtonPressed;

  /// Alternative action message (e.g., "Don't have an account?").
  final String alternativeActionMessage;

  /// Alternative action button text (e.g., "Sign up").
  final String alternativeActionText;

  /// Callback function when the alternative action button is pressed.
  final VoidCallback onAlternativeActionPressed;

  /// List of form fields to display in the form.
  final List<Widget> formFields;

  /// Title for the app bar.
  final String appBarTitle;

  /// Creates a [BaseAuthPage] widget.
  ///
  /// All parameters are required to ensure the page has all necessary elements.
  const BaseAuthPage({
    super.key,
    required this.formKey,
    required this.title,
    required this.subtitle,
    required this.primaryButtonText,
    required this.onPrimaryButtonPressed,
    required this.alternativeActionMessage,
    required this.alternativeActionText,
    required this.onAlternativeActionPressed,
    required this.formFields,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TapOutsideToUnfocus(
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ...formFields,
                  const SizedBox(height: 24),
                  DecoratedButton(
                    onPressed: onPrimaryButtonPressed,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      primaryButtonText,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: theme.colorScheme.surface),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(alternativeActionMessage),
                      TextButton(
                        onPressed: onAlternativeActionPressed,
                        child: Text(alternativeActionText),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

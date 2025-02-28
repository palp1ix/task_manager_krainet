import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_text_form_field.dart';
import 'package:task_manager_krainet/shared/widgets/base_auth_page.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
      print('Login with: ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    
    // Define form fields that are specific to login screen
    final formFields = [
      TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: localization.email,
          hintText: localization.enterEmail,
          prefixIcon: Icon(Icons.email),
          border: OutlineInputBorder().copyWith(
              borderRadius: BorderRadius.circular(
                  AppConstants.inputBorderRadius)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return localization.pleaseEnterEmail;
          }
          if (!RegExp(AppConstants.notValidEmailSymbols)
              .hasMatch(value)) {
            return localization.pleaseEnterValidEmail;
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      DecoratedTextFormField(
        controller: _passwordController,
        obscureText: !_isPasswordVisible,
        labelText: localization.password,
        hintText: localization.enterPassword,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return localization.pleaseEnterPassword;
          }
          return null;
        },
      ),
    ];

    // Use the BaseAuthPage widget with login-specific parameters
    return BaseAuthPage(
      formKey: _formKey,
      appBarTitle: localization.loginTitle,
      title: localization.welcomeBack,
      subtitle: localization.loginAccessAccount,
      primaryButtonText: localization.loginButton,
      onPrimaryButtonPressed: _handleLogin,
      alternativeActionMessage: localization.noAccount,
      alternativeActionText: localization.signUp,
      onAlternativeActionPressed: () {
        context.router.replace(SignupRoute());
      },
      formFields: formFields,
    );
  }
}

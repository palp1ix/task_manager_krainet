import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/presentation/blocs/auth/auth_bloc.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_text_form_field.dart';
import 'package:task_manager_krainet/shared/widgets/base_auth_page.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  // Key of form for validate
  final _formKey = GlobalKey<FormState>();
  // Input controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // Bloc instance
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    // If validate we add event for login
    if (_formKey.currentState!.validate()) {
      authBloc.add(AuthLogin(
        email: _emailController.text,
        password: _passwordController.text,
      ));
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
              borderRadius:
                  BorderRadius.circular(AppConstants.inputBorderRadius)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return localization.pleaseEnterEmail;
          }
          if (!RegExp(AppConstants.notValidEmailSymbols).hasMatch(value)) {
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
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
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

    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthInProgress) {
          showProgressIndicatorDialog(context);
        } else if (state is Authorized || state is AuthFailed) {
          // Close the dialog when auth completes (success or failure)
          Navigator.of(context).pop();

          // Success state
          if (state is Authorized) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.success,
                content: Text(localization.authorizeMessage),
              ),
            );
            context.router.replace(const HomeRoute());
          }
          // Show error message if authentication failed
          if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text(localization.errorMessage),
              ),
            );
          }
        }
      },
      // Use the BaseAuthPage widget with login-specific parameters
      child: BaseAuthPage(
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
      ),
    );
  }
}

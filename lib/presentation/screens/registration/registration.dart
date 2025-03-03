import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/presentation/blocs/auth/auth_bloc.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_text_form_field.dart';
import 'package:task_manager_krainet/shared/widgets/base_auth_page.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  late AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(AuthSignUp(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    // Define form fields specific to signup screen
    final formFields = [
      DecoratedTextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        labelText: localization.email,
        hintText: localization.enterEmail,
        prefixIcon: const Icon(Icons.email),
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
            return localization.pleaseEnterPasswordNew;
          }
          if (value.length < 6) {
            return localization.passwordMustBeSixChars;
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
      DecoratedTextFormField(
        controller: _confirmPasswordController,
        obscureText: !_isConfirmPasswordVisible,
        labelText: localization.confirmPassword,
        hintText: localization.confirmYourPassword,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
            });
          },
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return localization.pleaseConfirmPassword;
          }
          if (value != _passwordController.text) {
            return localization.passwordsDoNotMatch;
          }
          return null;
        },
      ),
    ];

    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
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
          else if (state is AuthFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text(localization.errorMessage),
              ),
            );
          } else if (state is SyncFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.error,
                content: Text(localization.syncError),
              ),
            );
          }
        }
      },
      // Use BaseAuthPage with signup-specific parameters
      child: BaseAuthPage(
        formKey: _formKey,
        appBarTitle: localization.registrationMainWord,
        title: localization.createAccount,
        subtitle: localization.signUpToGetStarted,
        formFields: formFields,
        primaryButtonText: localization.signUp,
        onPrimaryButtonPressed: _handleSignup,
        alternativeActionMessage: localization.haveAccount,
        alternativeActionText: localization.loginButton,
        onAlternativeActionPressed: () {
          context.router.replace(LoginRoute());
        },
      ),
    );
  }
}

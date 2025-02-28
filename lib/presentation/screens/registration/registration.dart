import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement signup logic
      print('Signup with: ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.registrationMainWord),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  localization.createAccount,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  localization.signUpToGetStarted,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: localization.fullName,
                    hintText: localization.enterFullName,
                    prefixIcon: const Icon(Icons.person),
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localization.pleaseEnterName;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: localization.email,
                    hintText: localization.enterEmail,
                    prefixIcon: const Icon(Icons.email),
                    border: const OutlineInputBorder(),
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
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
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
                    border: const OutlineInputBorder(),
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
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    labelText: localization.confirmPassword,
                    hintText: localization.confirmYourPassword,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    border: const OutlineInputBorder(),
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
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _handleSignup,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    localization.signUp,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localization.haveAccount),
                    TextButton(
                      onPressed: () {
                        context.router.replace(LoginRoute());
                      },
                      child: Text(localization.loginButton),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_krainet/core/constants/constants.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localization.loginTitle),
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
                  localization.welcomeBack,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  localization.loginAccessAccount,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: localization.email,
                    hintText: localization.enterEmail,
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
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
                      return localization.pleaseEnterPassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    localization.loginButton,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(localization.noAccount),
                    TextButton(
                      onPressed: () {
                        context.router.replace(SignupRoute());
                      },
                      child: Text(localization.signUp),
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

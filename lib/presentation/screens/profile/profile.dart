import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_krainet/presentation/blocs/auth/auth_bloc.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:task_manager_krainet/core/services/auth_service.dart';
import 'package:task_manager_krainet/shared/theme/colors.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_manager_krainet/shared/widgets/decorated_dialog.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  late User _user = _authService.currentUser!;
  late AuthBloc authBloc;

  @override
  void initState() {
    _user = _authService.currentUser!;
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final constrains = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthInProgress) {
          showProgressIndicatorDialog(context);
        } else if (state is Unauthorized) {
          context.router.replace(HomeRoute());
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: AppColors.error,
              content: Text(localization.errorMessage)));
        }
      },
      child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              children: [
                Text(_user.email ?? localization.noEmail),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: DecoratedButton(
                    height: 50,
                    width: constrains.width * 0.8,
                    onPressed: _onClickLogout,
                    color: Colors.red,
                    child: Text(localization.logout,
                        style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.surface, fontSize: 18)),
                  ),
                )
              ],
            ),
          )),
    );
  }

  // Push event for logout to bloc
  void _onClickLogout() {
    authBloc.add(AuthLogout());
  }
}

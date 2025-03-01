import 'package:auto_route/auto_route.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';
import 'package:task_manager_krainet/core/services/auth_service.dart';

class ProfileGuard implements AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Check if user is authenticated
    final bool isAuthenticated = checkIfUserIsAuthenticated();

    if (isAuthenticated) {
      // If authenticated, allow navigation to proceed
      resolver.next(true);
    } else {
      // If not authenticated, redirect to login page
      router.push(const LoginRoute());

      // Prevent navigation to the protected route
      resolver.next(false);
    }
  }

  bool checkIfUserIsAuthenticated() {
    final authSevice = AuthService();
    return authSevice.isLoggedIn;
  }
}

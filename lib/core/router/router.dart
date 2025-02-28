import 'package:auto_route/auto_route.dart';
import 'package:task_manager_krainet/core/router/router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: TasksScreenRoute.page, path: '/tasks'),
        AutoRoute(page: AddTaskRoute.page, path: '/add_task'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: SignupRoute.page, path: '/signup'),
      ];
}

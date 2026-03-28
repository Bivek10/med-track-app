import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../../features/history/presentation/pages/history_page.dart';
import '../../../features/medicine/presentation/pages/add_medicine_page.dart';
import '../../../features/medicine/presentation/pages/medicine_list_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/reminder/presentation/pages/reminder_page.dart';
import '../../../features/reports/presentation/pages/reports_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../shared/widgets/organisms/main_wrapper.dart';
import '../../../shared/widgets/organisms/page_not_found.dart';
import '../../utils/extension/bloc_extension.dart';
import 'route_path.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  late final AuthBloc authBloc;
  GoRouter get router => _goRouter;
  AppRouter(this.authBloc);

  late final _goRouter = GoRouter(
    initialLocation:
        authBloc.state is Authenticated
            ? AppPage.home.toPath
            : AppPage.login.toPath,
    refreshListenable: authBloc.asListenable(),
    navigatorKey: rootNavigatorKey,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPage.home.toPath,
                name: AppPage.home.toName,
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPage.medicineList.toPath,
                name: AppPage.medicineList.toName,
                builder: (context, state) => const MedicineListPage(),
                routes: [
                  GoRoute(
                    path: 'add-medicine',
                    name: AppPage.addMedicine.toName,
                    builder: (context, state) => const AddMedicinePage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPage.reports.toPath,
                name: AppPage.reports.toName,
                builder: (context, state) => const ReportsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppPage.profile.toPath,
                name: AppPage.profile.toName,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppPage.login.toPath,
        name: AppPage.login.toName,
        redirect: (context, state) {
          final state = authBloc.state;
          if (state is Authenticated) {
            return AppPage.home.toPath;
          }
          return null;
        },
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppPage.register.toPath,
        name: AppPage.register.toName,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppPage.settings.toPath,
        name: AppPage.settings.toName,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppPage.history.toPath,
        name: AppPage.history.toName,
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: AppPage.reminder.toPath,
        name: AppPage.reminder.toName,
        builder: (context, state) => const ReminderPage(),
      ),
    ],
    errorBuilder: (context, state) => const PageNotFoundView(),
    redirect: (context, state) {
      final isLoggedIn = authBloc.state is Authenticated;
      final isAuthPath =
          state.matchedLocation == AppPage.login.toPath ||
          state.matchedLocation == AppPage.register.toPath;

      if (!isLoggedIn && !isAuthPath) {
        return AppPage.login.toPath;
      }
      if (isLoggedIn && isAuthPath) {
        return AppPage.home.toPath;
      }
      return null;
    },
  );
}

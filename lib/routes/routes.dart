import 'package:anti_rigging/admin_dashboard/view/admin_dashboard_view.dart';
import 'package:anti_rigging/create_election/view/create_election_view.dart';
import 'package:anti_rigging/login/view/login_view.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/signup/view/signup_view.dart';
import 'package:anti_rigging/user_dashboard/view/user_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter createRouter({required bool isScriptsEnabled}) {
  final auth = AuthenticationService();
  return GoRouter(
    // redirect: (context, state) {
    //   if (auth.status == null) {
    //     return '/signup';
    //   } else {
    //     return null;
    //   }
    // },
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => NoTransitionPage(
          child: UserDashBoard.routeBuilder(context, state),
        ),
      ),
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) => NoTransitionPage(
          child: Login.routeBuilder(context, state),
        ),
      ),
      GoRoute(
        path: '/signup',
        pageBuilder: (context, state) => NoTransitionPage(
          child: SignUp.routeBuilder(context, state),
        ),
      ),
      GoRoute(
        name: 'admin',
        path: '/admin',
        pageBuilder: (context, state) => NoTransitionPage(
          child: AdminDashboad.routeBuilder(context, state),
        ),
      ),
      GoRoute(
        name: 'create_election',
        path: '/create_election',
        pageBuilder: (context, state) => NoTransitionPage(
          child: CreateElection.routeBuilder(context, state),
        ),
      ),
    ],
    observers: [RedirectToHomeObserver()],
  );
}

class RedirectToHomeObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (previousRoute == null && route.settings.name != '/') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = route.navigator!.context;
        GoRouter.of(context).go('/');
      });
    }
  }
}

import 'dart:developer';

import 'package:anti_rigging/admin_dashboard/view/admin_dashboard_view.dart';
import 'package:anti_rigging/login/view/login_view.dart';
import 'package:anti_rigging/models/user.dart';
import 'package:anti_rigging/services/auth/auth.dart';
import 'package:anti_rigging/services/db/db.dart';
import 'package:anti_rigging/signup/view/signup_view.dart';
import 'package:anti_rigging/user_dashboard/view/user_dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<GoRouter> createRouter({required bool isScriptsEnabled}) async {
  final auth = AuthenticationService();
  final db = DbService();
  bool status = (auth.status == null);
  AppUser? user;
  if (!status) {
    try {
      user = await db.getUser(auth.status!.uid);
    } catch (e) {
      log('$e');
    }
  }
  return GoRouter(
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (state.fullPath == '/signup') {
        return '/signup';
      }

      if (status) {
        return '/login';
      } else {
        return user!.accountType == 'admin' ? '/admin' : null;
      }
    },
    //initialLocation: auth.status != null ? '/' : '/login',
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

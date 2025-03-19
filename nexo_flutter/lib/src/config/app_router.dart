import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/config/session_manager.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/enums/location_status.dart';
import 'package:nexo_flutter/src/presentation/features/forgot_password/forgot_password_view.dart';
import 'package:nexo_flutter/src/presentation/features/join_game/join_game_view.dart';
import 'package:nexo_flutter/src/presentation/features/launch_game/launch_game_view.dart';
import 'package:nexo_flutter/src/presentation/features/location_permission/location_permission_view.dart';
import 'package:nexo_flutter/src/presentation/features/log_in/log_in_view.dart';
import 'package:nexo_flutter/src/presentation/features/register/register_view.dart';
import 'package:nexo_flutter/src/presentation/features/settings/settings_view.dart';

import '../presentation/features/home/home_view.dart';
import '../presentation/features/splash/splash_view.dart';

final routerProvider = Provider.autoDispose<GoRouter>(
  (ref) => GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      final isSignedIn = sessionManager.isSignedIn;

      if (!isSignedIn &&
          state.location != Routes.splash &&
          state.location != Routes.logIn &&
          state.location != Routes.register &&
          state.location != Routes.forgotPassword) {
        return Routes.splash;
      } else if (state.location == Routes.home) {
        final locationStatus =
            await ref.read(checkLocationStatusUseCaseProvider).call();

        if (locationStatus != LocationStatus.granted) {
          return Routes.locationPermission;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const SplashView(),
          );
        },
      ),
      GoRoute(
        path: Routes.logIn,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: LoginView(),
          );
        },
      ),
      GoRoute(
        path: Routes.forgotPassword,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: ForgotPasswordView(),
          );
        },
      ),
      GoRoute(
        path: Routes.register,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: RegisterView(),
          );
        },
      ),
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const HomeView(),
          );
        },
      ),
      GoRoute(
        path: Routes.settings,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const SettingsView(),
          );
        },
      ),
      GoRoute(
        path: Routes.locationPermission,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const LocationPermissionView(),
          );
        },
      ),
      GoRoute(
        path: Routes.launchGame,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const LaunchGameView(),
          );
        },
      ),
      GoRoute(
        path: Routes.joinhGame,
        pageBuilder: (context, state) {
          return MaterialPage<void>(
            key: state.pageKey,
            child: const JoinGameView(),
          );
        },
      ),
    ],
  ),
);

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';

import '../../../../domain/use_cases/auth/sign_out_use_case.dart';

final signOutProvider =
    StateNotifierProvider.autoDispose<SignOutNotifier, AsyncValue>(
  (ref) => SignOutNotifier(ref),
);

class SignOutNotifier extends StateNotifier<AsyncValue> {
  final StateNotifierProviderRef _ref;
  final SignOutUseCase _signOutUseCase;

  SignOutNotifier(this._ref)
      : _signOutUseCase = _ref.read(signOutUseCaseProvider),
        super(const AsyncValue.data(null));


  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      final result = await _signOutUseCase.call();

      if (result) {
        state = const AsyncValue.data(null);
        _ref.read(routerProvider).go(Routes.splash);
      } else {
        state = AsyncValue.error("Sign out failed", StackTrace.current);
      }
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }
}

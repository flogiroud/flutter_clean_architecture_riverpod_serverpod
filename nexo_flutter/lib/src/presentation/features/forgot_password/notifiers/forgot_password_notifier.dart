import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/initialite_password_reset_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/reset_password_use_case.dart';
import 'package:nexo_flutter/src/presentation/features/forgot_password/notifiers/forgot_password_step_notifier.dart';
import 'package:nexo_flutter/src/utils/error_type.dart';

final forgotPasswordProvider =
    StateNotifierProvider.autoDispose<ForgotPasswordNotifier, AsyncValue>(
        (ref) => ForgotPasswordNotifier(ref));

class ForgotPasswordNotifier extends StateNotifier<AsyncValue> {
  final StateNotifierProviderRef _ref;
  final InitiatePasswordResetUseCase _initiatePasswordResetUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgotPasswordNotifier(this._ref)
      : _initiatePasswordResetUseCase =
            _ref.read(initiatePasswordResetUseCaseProvider),
        _resetPasswordUseCase = _ref.read(resetPasswordUseCaseProvider),
        super(const AsyncValue.data(null));

  Future<void> initiatePasswordReset(String email) async {
    state = const AsyncValue.loading();
    try {
      final result = await _initiatePasswordResetUseCase.call(email: email);
      if (!result) {
        state = AsyncValue.error(
            ErrorType.initiatePasswordResetFailed, StackTrace.current);
        return;
      }
      state = const AsyncValue.data(null);
      _ref
          .read(forgotPasswordStepProvider.notifier)
          .onForgotPasswordCompleted();
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }

  Future<void> resetPassword(String code, String password) async {
    state = const AsyncValue.loading();
    try {
      final result = await _resetPasswordUseCase.call(
        code: code,
        password: password,
      );
      if (!result) {
        state =
            AsyncValue.error(ErrorType.resetPasswordFailed, StackTrace.current);
        return;
      }
      state = const AsyncValue.data(null);
      _ref.read(routerProvider).pop();
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/log_in_use_case.dart';
import 'package:nexo_flutter/src/presentation/utils/notifier_error_state_handler.dart';
import 'package:nexo_flutter/src/utils/error_type.dart';

import '../../../../utils/constants.dart';

final logInProvider =
    StateNotifierProvider.autoDispose<LogInNotifier, AsyncValue>(
        (ref) => LogInNotifier(ref));

class LogInNotifier extends StateNotifier<AsyncValue> {
  final StateNotifierProviderRef _ref;
  final LogInUseCase _logInUseCase;

  LogInNotifier(this._ref)
      : _logInUseCase = _ref.read(logInUseCaseProvider),
        super(const AsyncValue.data(null));

  Future<void> login(String email, String password) async {
    final trimedLowerCaseEmail = email.trim().toLowerCase();

    if (!_isEmailValid(trimedLowerCaseEmail)) {
      state = AsyncValue.error(ErrorType.invalidEmail, StackTrace.current);
      return;
    }
    if (!_isPasswordLengthValid(password)) {
      state = AsyncValue.error(ErrorType.passwordTooShort, StackTrace.current);
      return;
    }

    state = const AsyncValue.loading();
    try {
      await _logInUseCase.call(email: trimedLowerCaseEmail, password: password);
      state = const AsyncValue.data(null);
      _ref.read(routerProvider).push(Routes.home);
    } catch (e, trace) {
      state = NotifierErrorStateHandler.fromException(e, trace);
    }
  }

  bool _isEmailValid(String email) => RegExp(kEmailRegex).hasMatch(email);

  bool _isPasswordLengthValid(String password) =>
      password.length >= kPasswordMinLength;
}

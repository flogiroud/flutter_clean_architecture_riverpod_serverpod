import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/create_account_request_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/validate_account_use_case.dart';
import 'package:nexo_flutter/src/presentation/features/register/notifiers/register_step_notifier.dart';
import 'package:nexo_flutter/src/utils/constants.dart';
import 'package:nexo_flutter/src/utils/error_type.dart';

final registerProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, AsyncValue>(
  (ref) => RegisterNotifier(ref),
);

class RegisterNotifier extends StateNotifier<AsyncValue> {
  final StateNotifierProviderRef _ref;
  final CreateAccountRequestUseCase _createAccountRequestUseCase;
  final ValidateAccountUseCase _validateAccountUseCase;

  RegisterNotifier(this._ref)
      : _createAccountRequestUseCase =
            _ref.read(createAccountRequestUseCaseProvider),
        _validateAccountUseCase = _ref.read(validateAccountUseCaseProvider),
        super(const AsyncValue.data(null));

  Future<void> register(String pseudo, String email, String password) async {
    final trimedPseudo = pseudo.trim();
    final trimedLowerCaseEmail = email.trim().toLowerCase();

    if (!_isPseudoValid(trimedPseudo)) {
      state = AsyncValue.error(ErrorType.invalidPseudo, StackTrace.current);
      return;
    }
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
      final result = await _createAccountRequestUseCase.call(
        pseudo: trimedPseudo,
        email: trimedLowerCaseEmail,
        password: password,
      );
      if (!result) {
        state = AsyncValue.error(ErrorType.registerFailed, StackTrace.current);
        return;
      }
      state = const AsyncValue.data(null);
      _ref.read(registerStepProvider.notifier).onCreateCompleted();
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }

  bool _isPseudoValid(String pseudo) => pseudo.length >= kPseudoMinLength;

  bool _isEmailValid(String email) => RegExp(kEmailRegex).hasMatch(email);

  bool _isPasswordLengthValid(String password) =>
      password.length >= kPasswordMinLength;

  Future<void> validateAccount(String code, String email) async {
    state = const AsyncValue.loading();
    try {
      final result = await _validateAccountUseCase.call(
        code: code,
        email: email,
      );
      if (!result) {
        state = AsyncValue.error(
            ErrorType.validateAccountFailed, StackTrace.current);
        return;
      }
      state = const AsyncValue.data(null);
      _ref.read(routerProvider).go(Routes.logIn);
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }
}

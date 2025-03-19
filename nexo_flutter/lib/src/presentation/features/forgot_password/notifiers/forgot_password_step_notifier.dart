import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordStepProvider = StateNotifierProvider.autoDispose<
    ForgotPasswordStepNotifier, ForgotPasswordStep>(
  (ref) => ForgotPasswordStepNotifier(),
);

enum ForgotPasswordStep {
  forgotPassword,
  validateNewPassword,
}

class ForgotPasswordStepNotifier extends StateNotifier<ForgotPasswordStep> {
  ForgotPasswordStepNotifier() : super(ForgotPasswordStep.forgotPassword);

  void backToForgotPassword() => state = ForgotPasswordStep.forgotPassword;

  void onForgotPasswordCompleted() =>
      state = ForgotPasswordStep.validateNewPassword;
}

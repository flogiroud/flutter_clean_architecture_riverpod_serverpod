import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerStepProvider =
    StateNotifierProvider.autoDispose<RegisterStepNotifier, RegisterStep>(
  (ref) => RegisterStepNotifier(),
);

enum RegisterStep {
  createAccount,
  validateAccount,
}

class RegisterStepNotifier extends StateNotifier<RegisterStep> {
  RegisterStepNotifier() : super(RegisterStep.createAccount);

  void backToCreation() => state = RegisterStep.createAccount;

  void onCreateCompleted() => state = RegisterStep.validateAccount;
}

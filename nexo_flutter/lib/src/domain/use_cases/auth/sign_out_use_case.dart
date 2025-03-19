import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';

class SignOutUseCase {
  final IAuthRepository _repository;

  SignOutUseCase(this._repository);

  Future<bool> call() async {
    final isSignedOut = await _repository.signOut();
    final sessionsRefreshed = await _repository.refreshSession();

    return isSignedOut && sessionsRefreshed;
  }
}

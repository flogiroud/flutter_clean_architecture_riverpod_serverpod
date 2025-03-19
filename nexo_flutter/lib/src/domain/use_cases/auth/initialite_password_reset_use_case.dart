import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';

class InitiatePasswordResetUseCase {
  final IAuthRepository _repository;

  InitiatePasswordResetUseCase(this._repository);

  Future<bool> call({required String email}) =>
      _repository.initiatePasswordReset(email: email);
}

import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';

class CreateAccountRequestUseCase {
  final IAuthRepository _repository;

  CreateAccountRequestUseCase(this._repository);

  Future<bool> call(
          {required String pseudo,
          required String email,
          required String password}) =>
      _repository.createAccountRequest(
        pseudo: pseudo,
        email: email,
        password: password,
      );
}

import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';

class ValidateAccountUseCase {
  final IAuthRepository _repository;

  ValidateAccountUseCase(this._repository);

  Future<bool> call({required String email, required String code}) =>
      _repository.validateAccount(
        email: email,
        code: code,
      );
}

import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';

class ResetPasswordUseCase {
  final IAuthRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<bool> call({required String code, required String password}) =>
      _repository.resetPassword(code: code, password: password);
}

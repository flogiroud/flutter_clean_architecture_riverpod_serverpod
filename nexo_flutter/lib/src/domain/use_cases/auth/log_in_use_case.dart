import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';

class LogInUseCase {
  final IAuthRepository _repository;

  LogInUseCase(this._repository);

  Future<void> call({required String email, required String password}) =>
      _repository.login(email: email, password: password);
}

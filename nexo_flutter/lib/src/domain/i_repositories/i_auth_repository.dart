abstract class IAuthRepository {
  Future<bool> signOut();

  Future<bool> refreshSession();

  Future<void> login({
    required String email,
    required String password,
  });

  Future<bool> createAccountRequest({
    required String pseudo,
    required String email,
    required String password,
  });

  Future<bool> validateAccount({
    required String email,
    required String code,
  });

  Future<bool> initiatePasswordReset({
    required String email,
  });

  Future<bool> resetPassword({
    required String code,
    required String password,
  });
}

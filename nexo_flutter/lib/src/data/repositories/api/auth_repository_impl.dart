import 'package:nexo_flutter/src/config/client.dart';
import 'package:nexo_flutter/src/config/session_manager.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_auth_repository.dart';
import 'package:nexo_flutter/src/utils/custom_exception.dart';
import 'package:nexo_flutter/src/utils/error_type.dart';

class AuthRepositoryImpl implements IAuthRepository {
  @override
  Future<bool> signOut() => sessionManager.signOut();

  @override
  Future<bool> refreshSession() => sessionManager.refreshSession();

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final serverResponse =
          await client.modules.auth.email.authenticate(email, password);

      if (!serverResponse.success ||
          serverResponse.userInfo == null ||
          serverResponse.keyId == null ||
          serverResponse.key == null) {
        throw CustomExceptionOld(ErrorType.loginFailed,
            trace: StackTrace.current);
      }
      return sessionManager.registerSignedInUser(
        serverResponse.userInfo!,
        serverResponse.keyId!,
        serverResponse.key!,
      );
    } catch (e, trace) {
      throw CustomExceptionOld(ErrorType.loginFailed, trace: trace);
    }
  }

  @override
  Future<bool> createAccountRequest(
      {required String pseudo,
      required String email,
      required String password}) async {
    try {
      return await client.modules.auth.email.createAccountRequest(
        pseudo,
        email,
        password,
      );
    } catch (e, trace) {
      throw CustomExceptionOld(ErrorType.registerFailed, trace: trace);
    }
  }

  @override
  Future<bool> validateAccount(
      {required String email, required String code}) async {
    try {
      final result = await client.modules.auth.email.createAccount(email, code);

      return result != null;
    } catch (e, trace) {
      throw CustomExceptionOld(ErrorType.validateAccountFailed, trace: trace);
    }
  }

  @override
  Future<bool> initiatePasswordReset({required String email}) async {
    try {
      final result =
          await client.modules.auth.email.initiatePasswordReset(email);

      return result;
    } catch (e, trace) {
      throw CustomExceptionOld(ErrorType.validateAccountFailed, trace: trace);
    }
  }

  @override
  Future<bool> resetPassword(
      {required String code, required String password}) async {
    try {
      final result =
          await client.modules.auth.email.resetPassword(code, password);

      return result;
    } catch (e, trace) {
      throw CustomExceptionOld(ErrorType.validateAccountFailed, trace: trace);
    }
  }
}

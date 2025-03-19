import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nexo_flutter/src/domain/use_cases/auth/sign_out_use_case.dart';

import '../mock/i_repositories/i_auth_repository_mock.mocks.dart';

void main() {
  final mockAuthRepository = MockIAuthRepository();
  final useCase = SignOutUseCase(mockAuthRepository);
  group("SignOutUseCase", () {
    test("sign out success", () async {
      when(mockAuthRepository.signOut()).thenAnswer((_) async => true);
      when(mockAuthRepository.refreshSession()).thenAnswer((_) async => true);

      final result = await useCase.call();
      expect(result, true);
    });

    test("sign out failed (signOut() -> false)", () async {
      when(mockAuthRepository.signOut()).thenAnswer((_) async => false);
      when(mockAuthRepository.refreshSession()).thenAnswer((_) async => true);

      final result = await useCase.call();
      expect(result, false);
    });

    test("sign out failed (refreshSession() -> false)", () async {
      when(mockAuthRepository.signOut()).thenAnswer((_) async => true);
      when(mockAuthRepository.refreshSession()).thenAnswer((_) async => false);

      final result = await useCase.call();
      expect(result, false);
    });
  });
}

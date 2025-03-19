import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nexo_flutter/src/data/data_module.dart';
import 'package:nexo_flutter/src/presentation/features/settings/notifiers/sign_out_notifier.dart';

import '../mock/i_repositories/i_auth_repository_mock.mocks.dart';

void main() {
  ProviderContainer createProviderContainer(
      MockIAuthRepository authRepository) {
    final container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(authRepository),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group("SignOutNotifier", () {
    test('sign out success', () async {
      final mockAuthRepository = MockIAuthRepository();
      final container = createProviderContainer(mockAuthRepository);
      final notifier = container.read(signOutProvider.notifier);

      when(mockAuthRepository.signOut()).thenAnswer((_) async => true);
      when(mockAuthRepository.refreshSession()).thenAnswer((_) async => true);

      expectLater(
        notifier.stream,
        emitsInOrder([const AsyncValue.loading(), emits(isA<AsyncData>())]),
      );

      await notifier.signOut();
    });

    test('sign out failed (signOut() -> false)', () async {
      final mockAuthRepository = MockIAuthRepository();
      final container = createProviderContainer(mockAuthRepository);
      final notifier = container.read(signOutProvider.notifier);

      when(mockAuthRepository.signOut()).thenAnswer((_) async => false);
      when(mockAuthRepository.refreshSession()).thenAnswer((_) async => true);

      expectLater(
        notifier.stream,
        emitsInOrder([const AsyncValue.loading(), emits(isA<AsyncError>())]),
      );

      await notifier.signOut();
    });

    test('sign out failed (refreshSession() -> false)', () async {
      final mockAuthRepository = MockIAuthRepository();
      final container = createProviderContainer(mockAuthRepository);
      final notifier = container.read(signOutProvider.notifier);

      when(mockAuthRepository.signOut()).thenAnswer((_) async => true);
      when(mockAuthRepository.refreshSession()).thenAnswer((_) async => false);

      expectLater(
        notifier.stream,
        emitsInOrder([const AsyncValue.loading(), emits(isA<AsyncError>())]),
      );

      await notifier.signOut();
    });
  });
}

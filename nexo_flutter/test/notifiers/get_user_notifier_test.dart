// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:nexo_flutter/src/data/data_module.dart';
// import 'package:nexo_flutter/src/presentation/features/settings/notifiers/get_user_notifier.dart';

// import '../mock/i_repositories/i_user_repository_mock.mocks.dart';

// void main() {
//   ProviderContainer createProviderContainer(
//       MockIUserRepository userRepository) {
//     final container = ProviderContainer(
//       overrides: [
//         userRepositoryProvider.overrideWithValue(userRepository),
//       ],
//     );
//     addTearDown(container.dispose);
//     return container;
//   }

//   group("GetUserNotifier", () {
//     test('get user success', () async {
//       final mockUuthRepository = MockIUserRepository();
//       final container = createProviderContainer(mockUuthRepository);
//       final notifier = container.read(getUserProvider.notifier);

//       when(mockUuthRepository.getUser()).thenAnswer((_) async => true);

//       expectLater(
//         notifier.stream,
//         emitsInOrder([const AsyncValue.loading(), emits(isA<AsyncData>())]),
//       );

//       await notifier.signOut();
//     });
//   });
// }

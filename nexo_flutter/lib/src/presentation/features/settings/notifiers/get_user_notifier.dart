import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_client/nexo_client.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/user/get_user_use_case.dart';

final getUserProvider = StateNotifierProvider.autoDispose<GetUserNotifier,
    AsyncValue<NexoUserInfo>>(
  (ref) => GetUserNotifier(ref),
);

class GetUserNotifier extends StateNotifier<AsyncValue<NexoUserInfo>> {
  final Ref _ref;
  final GetUserUseCase _getUserUseCase;

  GetUserNotifier(this._ref)
      : _getUserUseCase = _ref.read(getUserUseCaseProvider),
        super(const AsyncValue.loading()) {
    getUser();
  }

  Future<void> getUser() async {
    state = const AsyncValue.loading();
    try {
      final user = await _getUserUseCase.call();
      state = AsyncValue.data(user);
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }

  void onPseudoUpdated(NexoUserInfo user) {
    state = AsyncValue.data(user);
  }

  void onImageUpdated(NexoUserInfo user) {
    state = AsyncValue.data(user);
  }
}

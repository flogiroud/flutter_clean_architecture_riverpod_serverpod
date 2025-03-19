import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/user/update_pseudo_use_case.dart';
import 'package:nexo_flutter/src/presentation/features/settings/notifiers/get_user_notifier.dart';

final updatePseudoProvider =
    StateNotifierProvider.autoDispose<UpdatePseudoNotifier, AsyncValue>(
  (ref) => UpdatePseudoNotifier(ref),
);

class UpdatePseudoNotifier extends StateNotifier<AsyncValue> {
  final StateNotifierProviderRef _ref;
  final UpdatePseudoUseCase _updatePseudoUseCase;

  UpdatePseudoNotifier(this._ref)
      : _updatePseudoUseCase = _ref.read(updatePseudoUseCaseProvider),
        super(const AsyncValue.data(null));

  Future<void> updatePseudo(String pseudo) async {
    state = const AsyncValue.loading();
    try {
      final updatedUser = await _updatePseudoUseCase.call(pseudo);
      _ref.read(getUserProvider.notifier).onPseudoUpdated(updatedUser);

      state = const AsyncValue.data(null);
    } catch (e) {
      state = const AsyncValue.data(null);
      // state = AsyncValue.error(e, trace);
    }
  }
}

import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/user/update_image_use_case.dart';
import 'package:nexo_flutter/src/presentation/features/settings/notifiers/get_user_notifier.dart';

final updateImageProvider =
    StateNotifierProvider.autoDispose<UpdateImageNotifier, AsyncValue>(
        (ref) => UpdateImageNotifier(ref));

class UpdateImageNotifier extends StateNotifier<AsyncValue> {
  final StateNotifierProviderRef _ref;
  final UpdateImageUseCase _updateImageUseCase;

  UpdateImageNotifier(this._ref)
      : _updateImageUseCase = _ref.read(updateImageUseCaseProvider),
        super(const AsyncValue.data(null));

  Future<void> updateImage({required ByteData data}) async {
    state = const AsyncValue.loading();
    try {
      final user = await _updateImageUseCase.call(data);
      state = const AsyncValue.data(null);
      _ref.read(getUserProvider.notifier).onImageUpdated(user);
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }
}

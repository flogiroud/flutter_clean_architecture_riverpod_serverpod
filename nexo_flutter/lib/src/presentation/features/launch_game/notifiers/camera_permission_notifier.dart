import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/use_cases/camera/check_camera_permission_status_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/camera/request_camera_permission_use_case.dart';
import 'package:permission_handler/permission_handler.dart';

final cameraPermissionProvider = StateNotifierProvider<CameraPermissionNotifier,
    AsyncValue<PermissionStatus>>((ref) {
  return CameraPermissionNotifier(ref);
});

class CameraPermissionNotifier
    extends StateNotifier<AsyncValue<PermissionStatus>> {
  final StateNotifierProviderRef _ref;
  final CheckCameraPermissionStatusUseCase _checkCameraStatusUseCase;
  final RequestCameraPermissionUseCase _requestCameraPermissionUseCase;

  bool get isCameraPermissionGranted => state.maybeWhen(
      data: (status) =>
          status == PermissionStatus.granted ||
          status == PermissionStatus.limited,
      orElse: () => false);

  CameraPermissionNotifier(this._ref)
      : _checkCameraStatusUseCase =
            _ref.read(checkCameraPermissionStatusUseCaseProvider),
        _requestCameraPermissionUseCase =
            _ref.read(requestCameraPermissionStatusUseCaseProvider),
        super(const AsyncValue.loading()) {
    _checkPermissionStatus();
  }

  Future<void> _checkPermissionStatus() async {
    state = const AsyncValue.loading();
    try {
      final cameraPermissionStatus = await _checkCameraStatusUseCase.call();

      state = AsyncValue.data(cameraPermissionStatus);
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }

  Future<void> requestCameraPermission() async {
    state = const AsyncValue.loading();
    try {
      final cameraPermissionStatus =
          await _requestCameraPermissionUseCase.call();

      state = AsyncValue.data(cameraPermissionStatus);
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }
}

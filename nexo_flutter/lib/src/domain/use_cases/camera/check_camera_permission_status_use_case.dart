import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckCameraPermissionStatusUseCase {
  final IDeviceRepository _repository;

  CheckCameraPermissionStatusUseCase(this._repository);

  Future<PermissionStatus> call() async {
    final permission = await _repository.getCameraPermissionStatus();

    return permission;
  }
}

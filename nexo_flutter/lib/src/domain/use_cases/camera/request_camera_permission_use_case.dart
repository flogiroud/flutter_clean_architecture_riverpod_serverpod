import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class RequestCameraPermissionUseCase {
  final IDeviceRepository _repository;

  RequestCameraPermissionUseCase(this._repository);

  Future<PermissionStatus> call() => _repository.requestCameraPermission();
}

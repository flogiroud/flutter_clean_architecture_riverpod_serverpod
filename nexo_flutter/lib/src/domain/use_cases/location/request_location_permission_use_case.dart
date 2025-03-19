import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';

class RequestLocationPermissionUseCase {
  final IDeviceRepository _repository;

  RequestLocationPermissionUseCase(this._repository);

  Future<void> call() => _repository.requestLocationPermission();
}

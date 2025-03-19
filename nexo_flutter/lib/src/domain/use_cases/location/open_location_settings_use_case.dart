import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';

class OpenLocationSettingsUseCase {
  final IDeviceRepository _repository;

  OpenLocationSettingsUseCase(this._repository);

  Future<void> call() => _repository.openLocationSettings();
}

import 'package:geolocator/geolocator.dart';
import 'package:nexo_flutter/src/domain/enums/location_status.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';

class CheckLocationStatusUseCase {
  final IDeviceRepository _repository;

  CheckLocationStatusUseCase(this._repository);

  Future<LocationStatus> call() async {
    final isLocationServiceEnabled =
        await _repository.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) return LocationStatus.disabled;

    final permission = await _repository.checkLocationPermission();

    if (permission == LocationPermission.denied) {
      return LocationStatus.denied;
    } else if (permission == LocationPermission.deniedForever) {
      return LocationStatus.deniedForever;
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return LocationStatus.granted;
    } else {
      return LocationStatus.unknown;
    }
  }
}

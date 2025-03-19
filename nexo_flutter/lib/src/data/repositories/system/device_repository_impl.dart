import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nexo_flutter/src/domain/i_repositories/i_device_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceRepositoryImpl implements IDeviceRepository {
  @override
  Future<bool> isLocationServiceEnabled() =>
      Geolocator.isLocationServiceEnabled();

  @override
  Future<LocationPermission> checkLocationPermission() =>
      Geolocator.checkPermission();

  @override
  Future<Position?> getPosition() => Geolocator.getCurrentPosition();

  @override
  Future<void> requestLocationPermission() => Geolocator.requestPermission();

  @override
  Future<void> openLocationSettings() => AppSettings.openLocationSettings();

  @override
  Future<PermissionStatus> getCameraPermissionStatus() =>
      Permission.camera.status;

  @override
  Future<PermissionStatus> requestCameraPermission() =>
      Permission.camera.request();
}

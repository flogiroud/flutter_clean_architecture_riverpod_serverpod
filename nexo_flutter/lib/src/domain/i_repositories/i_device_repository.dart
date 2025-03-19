import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IDeviceRepository {
  Future<bool> isLocationServiceEnabled();

  Future<LocationPermission> checkLocationPermission();

  Future<Position?> getPosition();

  Future<void> requestLocationPermission();

  Future<void> openLocationSettings();

  Future<PermissionStatus> getCameraPermissionStatus();

  Future<PermissionStatus> requestCameraPermission();
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/domain/domain_module.dart';
import 'package:nexo_flutter/src/domain/enums/location_status.dart';
import 'package:nexo_flutter/src/domain/use_cases/location/check_location_status_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/location/open_location_settings_use_case.dart';
import 'package:nexo_flutter/src/domain/use_cases/location/request_location_permission_use_case.dart';

final locationPermissionProvider = StateNotifierProvider.autoDispose<
    LocationPermissionNotifier, AsyncValue<LocationStatus>>((ref) {
  return LocationPermissionNotifier(ref);
});

class LocationPermissionNotifier
    extends StateNotifier<AsyncValue<LocationStatus>> {
  final StateNotifierProviderRef _ref;
  final CheckLocationStatusUseCase _checkLocationStatusUseCase;
  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  final OpenLocationSettingsUseCase _openLocationSettingsUseCase;

  LocationPermissionNotifier(this._ref)
      : _checkLocationStatusUseCase =
            _ref.read(checkLocationStatusUseCaseProvider),
        _requestLocationPermissionUseCase =
            _ref.read(requestLocationPermissionUseCaseProvider),
        _openLocationSettingsUseCase = _ref.read(openLocationUseCaseProvider),
        super(const AsyncValue.loading()) {
    _checkLocationStatus();
  }

  Future<void> _checkLocationStatus() async {
    state = const AsyncValue.loading();
    try {
      final locationStatus = await _checkLocationStatusUseCase.call();

      state = AsyncValue.data(locationStatus);
      if (state.value == LocationStatus.granted) {
        _ref.read(routerProvider).go(Routes.home);
      }
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }

  Future<void> requestLocationPermission() async {
    state = const AsyncValue.loading();
    try {
      await _requestLocationPermissionUseCase.call();
      await _checkLocationStatus();
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }

  Future<void> openLocationSettings() async {
    try {
      await _openLocationSettingsUseCase.call();
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
    }
  }
}

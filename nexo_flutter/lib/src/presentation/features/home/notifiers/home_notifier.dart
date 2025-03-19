import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, AsyncValue<Position>>(
    (ref) => HomeNotifier(ref));

class HomeNotifier extends StateNotifier<AsyncValue<Position>> {
  final MapController mapController = MapController();

  final Ref _ref;

  HomeNotifier(this._ref) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    final position = await _getPosition();

    if (position == null) return;
    state = AsyncValue.data(position);
  }

  void onPositionChanged(MapPosition position, bool p1) {
    // TODO: Implement onPositionChanged
  }

  Future<Position?> _getPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e, trace) {
      state = AsyncValue.error(e, trace);
      return null;
    }
  }

  void onMapReady() {
    FlutterCompass.events?.listen((CompassEvent event) {
      mapController.rotate(event.heading! * -1);
    });
  }
}

import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

class HomeController {
  final MapController mapController = MapController();

  HomeController() {
    _init();
  }

  void _init() async {
    await Future.delayed(const Duration(seconds: 1));
    FlutterCompass.events?.listen((CompassEvent event) {
      mapController.rotate(event.heading! * -1);
    });
  }

  Future<Position?> getPosition() async {
    final hasPermission = await _checkPermission();
    if (!hasPermission) return null;

    return await Geolocator.getCurrentPosition();
  }

  Future<bool> _checkPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) return false;

    await Geolocator.requestPermission();
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  void onPositionChanged(MapPosition position, bool p1) {
    // print(position);
  }
}

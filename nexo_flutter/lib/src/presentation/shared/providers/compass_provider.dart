import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final compassProvider =
    StreamProvider.autoDispose<CompassEvent>((ref) => FlutterCompass.events!);

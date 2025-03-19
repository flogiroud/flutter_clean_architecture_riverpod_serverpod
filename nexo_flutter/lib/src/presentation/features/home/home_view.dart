import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_loader.dart';

import '../../shared/widgets/custom_error_widget.dart';
import 'notifiers/home_notifier.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeNotifier = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: homeNotifier.maybeMap(
          orElse: () => const Center(child: CustomLoader()),
          error: (error) =>
              Center(child: CustomErrorWidget(error: error.error)),
          data: (value) => Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FlutterMap(
                        mapController:
                            ref.read(homeProvider.notifier).mapController,
                        options: MapOptions(
                          onMapReady:
                              ref.read(homeProvider.notifier).onMapReady,
                          onPositionChanged:
                              ref.read(homeProvider.notifier).onPositionChanged,
                          center: LatLng(
                              value.value.latitude, value.value.longitude),
                          zoom: 18,
                          keepAlive: true,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', // TODO: change to mapbox
                            userAgentPackageName: 'com.example.nexo_flutter',
                            additionalOptions: const {
                              "access_token": "",
                            },
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: LatLng(value.value.latitude,
                                    value.value.longitude),
                                builder: (ctx) => const Icon(
                                  Icons.arrow_upward_sharp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                          text: "Launch Game",
                          onPressed: () =>
                              ref.read(routerProvider).push(Routes.launchGame),
                        ),
                        const SizedBox(width: 20),
                        CustomButton(
                          text: "Join Game",
                          onPressed: () =>
                              ref.read(routerProvider).push(Routes.joinhGame),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                child: IconButton(
                  onPressed: () =>
                      ref.read(routerProvider).push(Routes.settings),
                  icon: const Icon(
                    Icons.person_2_rounded,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

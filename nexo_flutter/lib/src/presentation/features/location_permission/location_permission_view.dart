import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/domain/enums/location_status.dart';
import 'package:nexo_flutter/src/presentation/features/location_permission/notifiers/location_permission_notifier.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_error_widget.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_text.dart';

class LocationPermissionView extends ConsumerWidget {
  const LocationPermissionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationPermissionNotifier = ref.watch(locationPermissionProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: locationPermissionNotifier.maybeMap(
                  orElse: () => const SizedBox(),
                  loading: (_) => const Text("Loading..."),
                  error: (error) => CustomErrorWidget(error: error.error),
                  data: (data) {
                    final locationStatus = data.value;

                    if (locationStatus == LocationStatus.denied) {
                      return TextButton(
                        onPressed: () => ref
                            .read(locationPermissionProvider.notifier)
                            .requestLocationPermission(),
                        child: const Text(
                          "Request Permission",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(text: "Location Status: $locationStatus"),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => ref
                                .read(locationPermissionProvider.notifier)
                                .openLocationSettings(),
                            child: const Text('Open Location Settings'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

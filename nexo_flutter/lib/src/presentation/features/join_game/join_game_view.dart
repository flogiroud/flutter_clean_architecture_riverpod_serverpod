import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/presentation/features/launch_game/notifiers/camera_permission_notifier.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_error_widget.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_loader.dart';

class JoinGameView extends ConsumerWidget {
  const JoinGameView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraPermissionNotifier = ref.watch(cameraPermissionProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Join Game"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (cameraPermissionNotifier.hasError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child:
                      CustomErrorWidget(error: cameraPermissionNotifier.error!),
                ),
              cameraPermissionNotifier.maybeMap(
                orElse: () => const SizedBox(),
                loading: (_) => const CustomLoader(),
                data: (data) {
                  if (ref
                      .read(cameraPermissionProvider.notifier)
                      .isCameraPermissionGranted) {
                    return const _Scanner();
                  } else {
                    return CustomButton(
                      onPressed: () => ref
                          .read(cameraPermissionProvider.notifier)
                          .requestCameraPermission(),
                      text: "Request Camera Permission",
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Scanner extends StatelessWidget {
  const _Scanner();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/presentation/features/settings/notifiers/get_user_notifier.dart';
import 'package:nexo_flutter/src/presentation/features/settings/notifiers/sign_out_notifier.dart';
import 'package:nexo_flutter/src/presentation/features/settings/notifiers/update_pseudo_notifier.dart';
import 'package:nexo_flutter/src/presentation/features/settings/widgets/user_image_handler.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_error_widget.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_loader.dart';

// ignore: depend_on_referenced_packages, implementation_imports

import '../../shared/widgets/custom_text_field.dart';
import 'notifiers/update_image_notifier.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getUserNotifier = ref.watch(getUserProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => ref.read(routerProvider).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: getUserNotifier.maybeMap(
        orElse: () => const Center(
          child: CustomLoader(),
        ),
        data: (value) => Center(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                _UserImage(imageUrl: value.value.userInfo.imageUrl!),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(height: 16),
                _UpdateUserPseudo(pseudo: value.value.userInfo.userName),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const _SignOut(),
              ],
            ),
          ),
        ),
        error: (error) => CustomErrorWidget(error: error.error),
      ),
    );
  }
}

class _UserImage extends ConsumerWidget {
  final String imageUrl;

  const _UserImage({required this.imageUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateImageNotifier = ref.watch(updateImageProvider);

    return Column(
      children: [
        updateImageNotifier.maybeMap(
          orElse: () => const SizedBox(),
          loading: (_) => const CustomLoader(),
          error: (error) => CustomErrorWidget(error: error.error),
          data: (data) => GestureDetector(
            onTap: () {
              UserImageHandler.updateUserImage(
                  context: context,
                  onUpload: (data) => ref
                      .read(updateImageProvider.notifier)
                      .updateImage(data: data));
            },
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                width: 72,
                height: 72,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _UpdateUserPseudo extends ConsumerWidget {
  final String pseudo;

  final TextEditingController _pseudoController = TextEditingController();

  _UpdateUserPseudo({required this.pseudo}) {
    _pseudoController.text = pseudo;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updatePseudoNotifier = ref.watch(updatePseudoProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CustomTextField(
            controller: _pseudoController,
            text: AppLocalizations.of(context)!.pseudo,
          ),
          updatePseudoNotifier.maybeMap(
            orElse: () => const SizedBox(),
            error: (error) => Padding(
              padding: const EdgeInsets.only(top: 16),
              child: CustomErrorWidget(error: error.error),
            ),
          ),
          const SizedBox(height: 16),
          updatePseudoNotifier.maybeMap(
            orElse: () => const SizedBox(),
            loading: (_) => const CustomLoader(),
            data: (data) => CustomButton(
              onPressed: () =>
                  ref.read(updatePseudoProvider.notifier).updatePseudo(
                        _pseudoController.text,
                      ),
              text: AppLocalizations.of(context)!.updatePseudo,
            ),
          ),
        ],
      ),
    );
  }
}

class _SignOut extends ConsumerWidget {
  const _SignOut();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(signOutProvider);

    return Column(
      children: [
        if (settingsNotifier.hasError)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: CustomErrorWidget(error: settingsNotifier.error!),
          ),
        if (settingsNotifier.isLoading)
          const CustomLoader()
        else
          CustomButton(
            onPressed: () => ref.read(signOutProvider.notifier).signOut(),
            text: AppLocalizations.of(context)!.signOut,
          ),
      ],
    );
  }
}

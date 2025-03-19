import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_text.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Expanded(
                child: Center(
                  child: CustomText(
                    text: "NEXO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: AppLocalizations.of(context)!.enterGame,
                onPressed: () => ref.read(routerProvider).push(Routes.logIn),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

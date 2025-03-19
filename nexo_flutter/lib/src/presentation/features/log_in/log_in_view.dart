import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/routes.dart';
import 'package:nexo_flutter/src/presentation/features/log_in/notifiers/log_in_notifier.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_error_widget.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_loader.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_text_field.dart';

import '../../../config/app_router.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.logIn),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 56),
                CustomTextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  text: AppLocalizations.of(context)!.email,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  obscureText: true,
                  text: AppLocalizations.of(context)!.password,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Consumer(
                      builder: (_, ref, __) => CustomButton(
                          text: AppLocalizations.of(context)!.forgotPassword,
                          backgroundColor: Colors.transparent,
                          onPressed: () => ref
                              .read(routerProvider)
                              .push(Routes.forgotPassword)),
                    ),
                    const SizedBox(height: 12),
                    Consumer(
                      builder: (_, ref, __) => CustomButton(
                        text: AppLocalizations.of(context)!.signUp,
                        backgroundColor: Colors.transparent,
                        onPressed: () =>
                            ref.read(routerProvider).push(Routes.register),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Consumer(
                  builder: (_, ref, __) => ref.watch(logInProvider).maybeMap(
                        orElse: () => const SizedBox(),
                        error: (error) => CustomErrorWidget(error: error.error),
                      ),
                ),
                const Spacer(),
                Consumer(
                  builder: (_, ref, __) {
                    final logInNotifier = ref.watch(logInProvider);

                    if (logInNotifier.isLoading) {
                      return const CustomLoader();
                    }
                    return CustomButton(
                      text: AppLocalizations.of(context)!.logIn,
                      onPressed: () => ref.read(logInProvider.notifier).login(
                          _emailController.text, _passwordController.text),
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

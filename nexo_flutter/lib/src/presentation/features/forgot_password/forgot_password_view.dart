import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/presentation/features/forgot_password/notifiers/forgot_password_step_notifier.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_error_widget.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_loader.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_text_field.dart';

import '../../../config/app_router.dart';
import 'notifiers/forgot_password_notifier.dart';

class ForgotPasswordView extends ConsumerWidget {
  final TextEditingController _forgotPasswordEmailController =
      TextEditingController()..text = "a@a.ab";
  final TextEditingController _newPasswordController = TextEditingController()
    ..text = "aaaaaaaa";
  final TextEditingController _validationForgotCodeController =
      TextEditingController();

  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgotPasswordStepNotifier = ref.watch(forgotPasswordStepProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgotPassword),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () =>
              forgotPasswordStepNotifier == ForgotPasswordStep.forgotPassword
                  ? ref.read(routerProvider).pop()
                  : ref
                      .read(forgotPasswordStepProvider.notifier)
                      .backToForgotPassword(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Builder(
              builder: (context) {
                if (forgotPasswordStepNotifier ==
                    ForgotPasswordStep.validateNewPassword) {
                  return _ValidateNewPasswordForm(
                    validationCodeController: _validationForgotCodeController,
                    passwordController: _newPasswordController,
                  );
                } else {
                  return _ForgotPasswordForm(
                    emailController: _forgotPasswordEmailController,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailController;

  const _ForgotPasswordForm({
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 56),
        CustomTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          text: AppLocalizations.of(context)!.email,
        ),
        const SizedBox(height: 16),
        Consumer(builder: (_, ref, __) {
          final forgotPasswordNotifier = ref.watch(forgotPasswordProvider);

          return forgotPasswordNotifier.maybeMap(
            orElse: () => const SizedBox(),
            error: (error) => CustomErrorWidget(error: error.error),
          );
        }),
        const Spacer(),
        Consumer(
          builder: (_, ref, __) {
            final forgotPasswordNotifier = ref.watch(forgotPasswordProvider);

            if (forgotPasswordNotifier.isLoading) {
              return const CustomLoader();
            }
            return CustomButton(
              text: AppLocalizations.of(context)!.sendCode,
              onPressed: () => ref
                  .read(forgotPasswordProvider.notifier)
                  .initiatePasswordReset(emailController.text),
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _ValidateNewPasswordForm extends StatelessWidget {
  final TextEditingController validationCodeController;
  final TextEditingController passwordController;

  const _ValidateNewPasswordForm({
    required this.validationCodeController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 56),
        CustomTextField(
          controller: validationCodeController,
          text: AppLocalizations.of(context)!.validationCode,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: passwordController,
          obscureText: true,
          text: AppLocalizations.of(context)!.newPassword,
        ),
        const SizedBox(height: 16),
        Consumer(builder: (_, ref, __) {
          final forgotPasswordNotifier = ref.watch(forgotPasswordProvider);

          return forgotPasswordNotifier.maybeMap(
            orElse: () => const SizedBox(),
            error: (error) => CustomErrorWidget(error: error.error),
          );
        }),
        const Spacer(),
        Consumer(
          builder: (_, ref, __) {
            final forgotPasswordNotifier = ref.watch(forgotPasswordProvider);

            if (forgotPasswordNotifier.isLoading) {
              return const CustomLoader();
            }
            return CustomButton(
              onPressed: () =>
                  ref.read(forgotPasswordProvider.notifier).resetPassword(
                        validationCodeController.text,
                        passwordController.text,
                      ),
              text: AppLocalizations.of(context)!.validate,
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

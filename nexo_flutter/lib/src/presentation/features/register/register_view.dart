import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nexo_flutter/src/config/app_router.dart';
import 'package:nexo_flutter/src/presentation/features/register/notifiers/register_notifiers.dart';
import 'package:nexo_flutter/src/presentation/features/register/notifiers/register_step_notifier.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_button.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_error_widget.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_loader.dart';
import 'package:nexo_flutter/src/presentation/shared/widgets/custom_text_field.dart';

class RegisterView extends ConsumerWidget {
  final TextEditingController _pseudoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _validationCodeController =
      TextEditingController();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerStepNotifier = ref.watch(registerStepProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.signUp),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => registerStepNotifier == RegisterStep.createAccount
              ? ref.read(routerProvider).pop()
              : ref.read(registerStepProvider.notifier).backToCreation(),
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
                if (registerStepNotifier == RegisterStep.validateAccount) {
                  return _ValidateAccountForm(
                    validationCodeController: _validationCodeController,
                    emailController: _emailController,
                  );
                } else {
                  return _CreateAccountForm(
                    pseudoController: _pseudoController,
                    emailController: _emailController,
                    passwordController: _passwordController,
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

class _CreateAccountForm extends StatelessWidget {
  final TextEditingController pseudoController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _CreateAccountForm({
    required this.pseudoController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 56),
        CustomTextField(
          controller: pseudoController,
          text: AppLocalizations.of(context)!.pseudo,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          text: AppLocalizations.of(context)!.email,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          controller: passwordController,
          obscureText: true,
          text: AppLocalizations.of(context)!.password,
        ),
        const SizedBox(height: 16),
        Consumer(builder: (_, ref, __) {
          final registerNotifier = ref.watch(registerProvider);

          return registerNotifier.maybeMap(
            orElse: () => const SizedBox(),
            error: (error) => CustomErrorWidget(error: error.error),
          );
        }),
        const Spacer(),
        Consumer(
          builder: (_, ref, __) {
            final registerNotifier = ref.watch(registerProvider);

            if (registerNotifier.isLoading) {
              return const CustomLoader();
            }
            return CustomButton(
              onPressed: () => ref.read(registerProvider.notifier).register(
                  pseudoController.text,
                  emailController.text,
                  passwordController.text),
              text: AppLocalizations.of(context)!.signUp,
            );
          },
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

class _ValidateAccountForm extends StatelessWidget {
  final TextEditingController validationCodeController;
  final TextEditingController emailController;

  const _ValidateAccountForm({
    required this.validationCodeController,
    required this.emailController,
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
        Consumer(builder: (_, ref, __) {
          final registerNotifier = ref.watch(registerProvider);

          return registerNotifier.maybeMap(
            orElse: () => const SizedBox(),
            error: (error) => CustomErrorWidget(error: error.error),
          );
        }),
        const Spacer(),
        Consumer(
          builder: (_, ref, __) {
            final registerNotifier = ref.watch(registerProvider);

            if (registerNotifier.isLoading) {
              return const CustomLoader();
            }
            return CustomButton(
              onPressed: () =>
                  ref.read(registerProvider.notifier).validateAccount(
                        validationCodeController.text,
                        emailController.text,
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

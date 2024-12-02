import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/register_screen/cubit/register_cubit.dart';
import 'package:landlords_web_app/frontend/register_screen/widgets/register_inputs.dart';
import 'package:landlords_web_app/frontend/register_screen/widgets/sign_up_button.dart';
import 'package:responsive_framework/responsive_framework.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.formzStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error.toString())),
            );
        }
      },
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: MaxWidthBox(
                    maxWidth: 700,
                    child: ResponsiveScaledBox(
                      width:
                          ResponsiveValue<double>(context, conditionalValues: [
                        const Condition.equals(name: MOBILE, value: 300),
                        const Condition.between(
                            start: 451, end: 800, value: 400),
                        const Condition.between(
                            start: 800, end: 1100, value: 500),
                        const Condition.between(
                            start: 1000, end: 1200, value: 600),
                        const Condition.largerThan(name: TABLET, value: 700),
                      ]).value,
                      child: Card(
                        elevation: 10,
                        color: LandingPageColors.cardColor.color,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SelectableText(
                                    "Register",
                                    style: theme.textTheme.headlineMedium!
                                        .copyWith(
                                            color: ColorSeed
                                                .darkPrimaryText.color),
                                  ),
                                  SelectableText(
                                    "Create a new account by providing your information below.",
                                    style: theme.textTheme.bodyMedium!.copyWith(
                                        color: ColorSeed.darkPrimaryText.color),
                                  ),
                                  const SizedBox(height: 16),
                                  const EmailInput(),
                                  const SizedBox(height: 8),
                                  const PasswordInput(),
                                  const SizedBox(height: 8),
                                  const ConfirmPasswordInput(),
                                  const SizedBox(height: 8),
                                  const NameInput(),
                                  const SizedBox(height: 8),
                                  const PhoneNumberInput(),
                                  const SizedBox(height: 8),
                                  const SignUpButton(),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

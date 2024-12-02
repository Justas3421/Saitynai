import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/register_screen/cubit/register_cubit.dart';
import 'package:landlords_web_app/frontend/register_screen/widgets/gradient_button.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, appState) {},
      builder: (context, appState) {
        return BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) {
            return appState.formzStatus.isInProgress
                ? const CircularProgressIndicator()
                : Center(
                    child: GradientButton(
                    onPressed: state.isValid
                        ? () => context.read<AuthCubit>().register(
                              state.email.value,
                              state.password.value,
                              state.name.value,
                            )
                        : null,
                    label: "Sign Up",
                    isValid: state.isValid,
                  ));
          },
        );
      },
    );
  }
}

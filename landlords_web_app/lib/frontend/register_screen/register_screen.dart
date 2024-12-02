import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/constants/top_back_button.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/landing_background.dart';
import 'package:landlords_web_app/frontend/register_screen/cubit/register_cubit.dart';
import 'package:landlords_web_app/frontend/register_screen/widgets/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: RegisterPage());

  static String route = "/register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => RegisterCubit(),
          child: BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
            if (state.status.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      content: Text(state.errorMessage ?? 'Sign Up Failure')),
                );
            }
          }, builder: (context, state) {
            return SelectionArea(
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Stack(
                  children: [
                    const LandingBackground(),
                    switch (state.status) {
                      FormzSubmissionStatus.initial => const RegisterForm(),
                      FormzSubmissionStatus.inProgress =>
                        const CircularProgressIndicator(),
                      FormzSubmissionStatus.success =>
                        const CircularProgressIndicator(),
                      FormzSubmissionStatus.failure => const RegisterForm(),
                      FormzSubmissionStatus.canceled => const RegisterForm(),
                    },
                    TopBackButton(onPressed: (Navigator.of(context).pop)),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

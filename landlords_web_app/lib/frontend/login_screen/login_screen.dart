import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/login_screen/cubit/login_cubit.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/landing_background.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  static String route = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SelectionArea(
          child: Padding(
              padding: const EdgeInsets.all(8),
              child: BlocProvider(
                create: (_) => LoginCubit(),
                child: BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.formzStatus.isFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content:
                              Text(state.error ?? 'Authentication Failure'),
                        ));
                    }
                  },
                  builder: (context, state) {
                    return Scaffold(
                      backgroundColor: Colors.black,
                      body: Stack(
                        children: [
                          const LandingBackground(),
                          switch (state.formzStatus) {
                            FormzSubmissionStatus.initial => const LoginForm(),
                            FormzSubmissionStatus.inProgress =>
                              const CircularProgressIndicator(),
                            FormzSubmissionStatus.success =>
                              const CircularProgressIndicator(),
                            FormzSubmissionStatus.failure => const LoginForm(),
                            FormzSubmissionStatus.canceled => const LoginForm(),
                          },
                        ],
                      ),
                    );
                  },
                ),
              )),
        ));
  }
}

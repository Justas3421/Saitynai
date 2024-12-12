import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/frontend/auth_screen/cubit/auth_cubit.dart';
import 'package:landlords_web_app/frontend/login_screen/login_screen.dart';
import 'package:landlords_web_app/frontend/profile_screen/profile_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return ProfileScreen(user: state.user);
        } else {
          return const LoginPage();
        }
      },
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/login_screen/cubit/login_cubit.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/email_input.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/login_button.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/password_input.dart';
import 'package:landlords_web_app/frontend/login_screen/widgets/sign_up_button.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Center(
          child: Card(
            elevation: 7,
            shadowColor: Colors.grey,
            color: LandingPageColors.cardColor.color,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: theme.textTheme.headlineMedium!
                          .copyWith(color: ColorSeed.darkPrimaryText.color),
                    ),
                    Text(
                      "Sign into your account by entering your information below.",
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: ColorSeed.darkSecondaryText.color),
                    ),
                    const UsernameInput(),
                    const PasswordInput(),
                    Center(
                      child: ResponsiveRowColumn(
                        columnSpacing: 15,
                        layout: ResponsiveRowColumnType.COLUMN,
                        rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ResponsiveRowColumnItem(child: LoginButton()),
                          ResponsiveRowColumnItem(
                            child: AutoSizeText(
                              'Don`t have an account?',
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          const ResponsiveRowColumnItem(child: SignUpButton()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

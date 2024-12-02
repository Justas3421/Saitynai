import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/login_screen/cubit/login_cubit.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? LandingPageColors.accentColor.color
                  : LandingPageColors.cardColor.color,
            ),
            hoverColor: LandingPageColors.accentColor.color,
            helperText: '',
            errorText:
                state.email.displayError != null ? 'Invalid email' : null,
          ),
        );
      },
    );
  }
}

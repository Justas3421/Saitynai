import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/login_screen/cubit/login_cubit.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (username) =>
              context.read<LoginCubit>().usernameChanged(username),
          keyboardType: TextInputType.text,
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
                state.username.displayError != null ? 'Invalid username' : null,
          ),
        );
      },
    );
  }
}

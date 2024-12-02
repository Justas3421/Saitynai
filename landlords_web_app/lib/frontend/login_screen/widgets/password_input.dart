import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/login_screen/cubit/login_cubit.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({super.key});

  @override
  PasswordInputState createState() => PasswordInputState();
}

class PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          obscureText: _obscureText,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            helperText: '',
            fillColor: WidgetStateColor.resolveWith((states) =>
                states.contains(WidgetState.focused)
                    ? LandingPageColors.accentColor.color
                    : LandingPageColors.cardColor.color),
            hoverColor: LandingPageColors.accentColor.color,
            errorText:
                state.password.displayError != null ? 'Invalid password' : null,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
        );
      },
    );
  }
}

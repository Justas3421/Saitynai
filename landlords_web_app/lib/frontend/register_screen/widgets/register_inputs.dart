import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:landlords_web_app/constants/colors.dart';
import 'package:landlords_web_app/frontend/register_screen/cubit/register_cubit.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (email) =>
              context.read<RegisterCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? LandingPageColors.accentColor.color
                  : LandingPageColors.cardColor.color,
            ),
            labelText: 'Email address',
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            helperText: '',
            errorText: state.email.displayError != null
                ? 'Invalid email address'
                : null,
          ),
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (password) =>
              context.read<RegisterCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? LandingPageColors.accentColor.color
                  : LandingPageColors.cardColor.color,
            ),
            hoverColor: LandingPageColors.accentColor.color,
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            labelText: 'Password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  const ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (confirmPassword) => context
              .read<RegisterCubit>()
              .confirmPasswordChanged(confirmPassword),
          obscureText: true,
          decoration: InputDecoration(
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? LandingPageColors.accentColor.color
                  : LandingPageColors.cardColor.color,
            ),
            hoverColor: LandingPageColors.accentColor.color,
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            labelText: 'Confirm password',
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? 'Passwords do not match'
                : null,
          ),
        );
      },
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_nameInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (name) => context.read<RegisterCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? LandingPageColors.accentColor.color
                  : LandingPageColors.cardColor.color,
            ),
            hoverColor: LandingPageColors.accentColor.color,
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            labelText: 'Name',
            helperText: '',
            errorText: state.name.displayError != null ? 'invalid name' : null,
          ),
        );
      },
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.phoneNumber != current.phoneNumber,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_phoneNumberInput_textField'),
          style: theme.textTheme.bodyMedium!
              .copyWith(color: ColorSeed.darkPrimaryText.color),
          onChanged: (phoneNumber) =>
              context.read<RegisterCubit>().phoneNumberChanged(phoneNumber),
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.focused)
                  ? LandingPageColors.accentColor.color
                  : LandingPageColors.cardColor.color,
            ),
            hoverColor: LandingPageColors.accentColor.color,
            labelStyle: TextStyle(color: ColorSeed.darkSecondaryText.color),
            labelText: 'Phone number',
            helperText: '',
            errorText: state.phoneNumber.displayError != null
                ? 'Invalid phone number'
                : null,
          ),
        );
      },
    );
  }
}

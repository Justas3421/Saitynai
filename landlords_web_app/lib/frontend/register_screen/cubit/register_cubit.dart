import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/backend/auth_repository/models/confirmed_password.dart';
import 'package:landlords_web_app/backend/auth_repository/models/email.dart';
import 'package:landlords_web_app/backend/auth_repository/models/name.dart';
import 'package:landlords_web_app/backend/auth_repository/models/password.dart';
import 'package:landlords_web_app/backend/auth_repository/models/phone_number.dart';
import 'package:landlords_web_app/backend/auth_repository/models/surname.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  /// Called when the email input changes.
  /// Updates the state with the new email and validates the form.
  ///
  /// [value] - The updated email string.
  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([
        email,
        state.password,
        state.confirmedPassword,
        state.phoneNumber,
        state.name,
      ]),
    ));
  }

  /// Called when the password input changes.
  /// Updates the password and revalidates the confirmed password.
  ///
  /// [value] - The updated password string.
  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
        password: password.value, value: state.confirmedPassword.value);

    emit(state.copyWith(
      password: password,
      confirmedPassword: confirmedPassword,
      isValid: Formz.validate([
        state.email,
        password,
        confirmedPassword,
        state.phoneNumber,
        state.name,
      ]),
    ));
  }

  /// Called when the confirmed password input changes.
  /// Updates the confirmed password and checks its validity against the password.
  ///
  /// [value] - The updated confirmed password string.
  void confirmPasswordChanged(String value) {
    final confirmedPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);

    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      isValid: Formz.validate([
        state.email,
        state.password,
        confirmedPassword,
        state.phoneNumber,
        state.name,
      ]),
    ));
  }

  /// Called when the name input changes.
  /// Updates the name and validates the form.
  ///
  /// [value] - The updated name string.
  void nameChanged(String value) {
    final name = Name.dirty(value);

    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([
        state.email,
        state.password,
        state.phoneNumber,
        state.confirmedPassword,
        name,
      ]),
    ));
  }

  void phoneNumberChanged(String value) {
    final name = Name.dirty(value);

    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([
        state.email,
        state.password,
        state.confirmedPassword,
        state.phoneNumber,
        name,
      ]),
    ));
  }
}

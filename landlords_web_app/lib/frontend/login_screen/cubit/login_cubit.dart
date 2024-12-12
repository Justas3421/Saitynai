import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/backend/auth_repository/models/password.dart';
import 'package:landlords_web_app/backend/auth_repository/models/username.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  /// Called when the email field changes.
  /// Validates the email and updates the state accordingly.
  ///
  /// [value] - The new value of the email input.
  void usernameChanged(String value) {
    // Create an 'Email' object that is marked as 'dirty' to indicate it has been modified.
    final username = Username.dirty(value);

    emit(
      state.copyWith(
        username: username,
        // Validate the form using the Formz library, checking both email and password.
        isValid: Formz.validate([username, state.password]),
      ),
    );
  }

  /// Called when the password field changes.
  /// Validates the password and updates the state accordingly.
  ///
  /// [value] - The new value of the password input.
  void passwordChanged(String value) {
    // Create a 'Password' object that is marked as 'dirty'.
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        // Validate the form using the Formz library, checking both email and password.
        isValid: Formz.validate([state.username, password]),
      ),
    );
  }
}

import 'package:formz/formz.dart';

/// Validation errors for the [Surname] [FormzInput].
enum SurnameValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template surname}
/// Form input for an surname input.
/// {@endtemplate}
class Surname extends FormzInput<String, SurnameValidationError> {
  /// {@macro email}
  const Surname.pure() : super.pure('');

  /// {@macro email}
  const Surname.dirty([super.value = '']) : super.dirty();

  static final RegExp _surnameRegExp = RegExp(
    r"^[a-zA-Z]+(?:[ '-][a-zA-Z]+)*$",
  );

  @override
  SurnameValidationError? validator(String? value) {
    return _surnameRegExp.hasMatch(value ?? '')
        ? null
        : SurnameValidationError.invalid;
  }
}

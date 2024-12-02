import 'package:formz/formz.dart';

/// Validation errors for the [Email] [FormzInput].
enum PhoneNumberValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template email}
/// Form input for an email input.
/// {@endtemplate}
class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  /// {@macro email}
  const PhoneNumber.pure() : super.pure('');

  /// {@macro email}
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z]+(?:[ '-][a-zA-Z]+)*$",
  );

  @override
  PhoneNumberValidationError? validator(String? value) {
    return _emailRegExp.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}

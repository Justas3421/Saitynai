part of 'register_cubit.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.phoneNumber = const PhoneNumber.pure(),
    this.name = const Name.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Name name;
  final FormzSubmissionStatus status;
  final PhoneNumber phoneNumber;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        email,
        password,
        confirmedPassword,
        name,
        status,
        phoneNumber,
        isValid,
        errorMessage,
      ];

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Name? name,
    Surname? surname,
    FormzSubmissionStatus? status,
    PhoneNumber? phoneNumber,
    bool? isValid,
    String? errorMessage,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      name: name ?? this.name,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

part of 'login_cubit.dart';

final class LoginState extends Equatable {
  final Username username;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;

  const LoginState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  @override
  List<Object?> get props => [username, password, status, isValid];

  LoginState copyWith({
    Username? username,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }
}

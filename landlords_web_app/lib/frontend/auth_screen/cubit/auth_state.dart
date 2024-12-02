part of 'auth_cubit.dart';

enum AuthStatus {
  authenticated,
  inProgressRegister,
  inProgressLogin,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User user;
  final FormzSubmissionStatus formzStatus;
  final String? error;

  const AuthState({
    this.status = AuthStatus.unauthenticated,
    this.formzStatus = FormzSubmissionStatus.initial,
    this.user = User.empty,
    this.error = "",
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    FormzSubmissionStatus? formzStatus,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      formzStatus: formzStatus ?? this.formzStatus,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, formzStatus, error];
}

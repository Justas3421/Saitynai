import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:landlords_web_app/backend/auth_repository/auth_repository.dart';
import 'package:landlords_web_app/backend/auth_repository/models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(const AuthState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(status: AuthStatus.inProgressLogin));
    User user = await _authRepository.login(email, password);
    emit(state.copyWith(status: AuthStatus.authenticated, user: user));
  }

  Future<void> register(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    emit(state.copyWith(
      status: AuthStatus.inProgressRegister,
    ));
    User user = await _authRepository.register(email, password, name, role);
    emit(state.copyWith(status: AuthStatus.authenticated, user: user));
  }

  Future<void> logout() async {
    emit(state.copyWith(
      status: AuthStatus.inProgressLogin,
    ));
    await _authRepository.logout(state.user.refreshToken);
    emit(state.copyWith(status: AuthStatus.authenticated, user: User.empty));
  }
}

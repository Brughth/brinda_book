part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final String? message;

  const AuthState({this.message});
}

final class AuthInitial extends AuthState {}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  const LoginFailure({required super.message});
}

final class LoginSuccess extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterFailure extends AuthState {
  const RegisterFailure({required super.message});
}

final class RegisterSuccess extends AuthState {}

part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuceess extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

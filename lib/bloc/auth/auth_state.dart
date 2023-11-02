part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class SigningInState extends AuthState {}

final class SignedInSuccessState extends AuthState {}

final class SignedInFailedState extends AuthState {}

final class SigningUpState extends AuthState {}

final class SignedUpSuccessState extends AuthState {}

final class SignedUpFailedState extends AuthState {}

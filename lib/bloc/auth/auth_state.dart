part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

/// Sign In States
final class SigningInState extends AuthState {
  final String signingInMessage;
  const SigningInState({required this.signingInMessage});
}

final class SignedInSuccessState extends AuthState {
  final String successMessage;
  final UserModel user;
  const SignedInSuccessState(
      {required this.user, required this.successMessage});
}

final class SignedInFailedState extends AuthState {
  final String failureMessage;
  const SignedInFailedState({required this.failureMessage});
}

/// Sign up States
final class SigningUpState extends AuthState {
  final String signingUpMessage;
  const SigningUpState({required this.signingUpMessage});
}

final class SignedUpSuccessState extends AuthState {
  final String successMessage;
  final UserModel user;
  const SignedUpSuccessState({
    required this.successMessage,
    required this.user,
  });
}

final class SignedUpFailedState extends AuthState {
  final String signingUpFailureMessage;
  const SignedUpFailedState({required this.signingUpFailureMessage});
}

final class SignedUpEventErrorState extends AuthState {
  final String signedUpEventErrorMsg;
  const SignedUpEventErrorState({required this.signedUpEventErrorMsg});
}

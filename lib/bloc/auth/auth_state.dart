part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class UnAuthenticatedState extends AuthState {}

final class AuthenticatedState extends AuthState {
  final UserModel loggedUserDate;

  const AuthenticatedState({required this.loggedUserDate});
}

/// Sign In States
final class SigningInState extends UnAuthenticatedState {
  final String signingInMessage;
  SigningInState({required this.signingInMessage});
}

final class SignedInSuccessState extends UnAuthenticatedState {
  final String successMessage;
  final UserModel user;
  SignedInSuccessState({required this.user, required this.successMessage});
}

final class SignedInFailedState extends UnAuthenticatedState {
  final String failureMessage;
  SignedInFailedState({required this.failureMessage});
}

/// Sign up States
final class SigningUpState extends UnAuthenticatedState {
  final String signingUpMessage;
  SigningUpState({required this.signingUpMessage});
}

final class SignedUpSuccessState extends UnAuthenticatedState {
  final String successMessage;
  final UserModel user;
  SignedUpSuccessState({
    required this.successMessage,
    required this.user,
  });
}

final class SignedUpFailedState extends UnAuthenticatedState {
  final String signingUpFailureMessage;
  SignedUpFailedState({required this.signingUpFailureMessage});
}

final class SignedUpEventErrorState extends UnAuthenticatedState {
  final String signedUpEventErrorMsg;
  SignedUpEventErrorState({required this.signedUpEventErrorMsg});
}

part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CheckAuthenticationEvent extends AuthEvent {}

/// Sign In Events

class EmailSignInEvent extends AuthEvent {
  final String email;
  final String password;
  const EmailSignInEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class FacebookSignInEvent extends AuthEvent {
  const FacebookSignInEvent();
}

class GoogleSignInEvent extends AuthEvent {
  const GoogleSignInEvent();
}

/// Sign In Events
class EmailSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  const EmailSignUpEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class FacebookSignUpEvent extends AuthEvent {
  const FacebookSignUpEvent();
}

class GoogleSignUpEvent extends AuthEvent {
  const GoogleSignUpEvent();
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/model/user.dart';
import 'package:todo/services/remote_db/auth_services.dart';
import 'package:todo/services/remote_db/user_services.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authServices;
  final UserServices _userServices;

  AuthBloc(this._authServices, this._userServices) : super(AuthInitial()) {
    on<EmailSignInEvent>(emailSignIn);
    on<FacebookSignInEvent>(facebookSignIn);
    on<GoogleSignInEvent>(googleSignIn);
    on<EmailSignUpEvent>(emailSignUp);
  }

  /// Sign up Bloc

  Future<void> emailSignIn(
      EmailSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const SigningInState(signingInMessage: 'Signing In.....'));
      await _authServices.firebaseEmailSignIn(
          emailId: event.email, password: event.password);
      final user = await _userServices.getUser(userId: event.email);
      emit(SignedInSuccessState(
        successMessage: event.email,
        user: user,
      ));
    } catch (e) {
      emit(SignedInFailedState(failerMessage: '$e'));
    }
  }

  Future<void> facebookSignIn(
      FacebookSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const SigningInState(signingInMessage: 'Signing In.....'));
      final UserCredential loggedInUsedData =
          await _authServices.firebaseFacebookSignIn();
      final user = await _userServices.getUser(
          userId: loggedInUsedData.additionalUserInfo!.profile.toString());
      emit(SignedInSuccessState(successMessage: "", user: user));
    } catch (e) {
      emit(SignedInFailedState(failerMessage: 'Facebook sign up error$e'));
    }
  }

  Future<void> googleSignIn(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const SigningInState(signingInMessage: 'Signing In.....'));

      await _authServices.firebaseGoogleSignIn();
      final user = await _userServices.getUser(userId: "nvbalaji6@gmail.com");
      emit(SignedInSuccessState(
          successMessage: "nvbalaji6@gmail.com", user: user));
    } catch (e) {
      emit(SignedInFailedState(failerMessage: 'Google sign up error$e'));
    }
  }

  /// Sign in Bloc

  Future<void> emailSignUp(
      EmailSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(const SigningUpState(signingUpMessage: 'Signing Up.....'));
      await _authServices.firebaseEmailSignUp(
          emailId: event.email, password: event.password);
      await _userServices.addUser(
          userDate: UserModel(
              userName: event.email,
              userId: event.email,
              loginType: "Email",
              userProfileImage: ""));
      final UserModel userData =
          await _userServices.getUser(userId: event.email);
      emit(SignedUpSuccessState(
          successMessage: 'Signed up as ${userData.userName}', user: userData));
    } catch (e) {
      emit(SignedUpFailedState(signingUpFailureMessage: e.toString()));
    }
  }
}

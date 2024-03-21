import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/model/user.dart';
import 'package:todo/services/local_db/user_local_services.dart';
import 'package:todo/services/remote_db/auth_services.dart';
import 'package:todo/services/remote_db/user_services.dart';
import 'package:todo/view/home_screen/home_screen.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authServices;
  final UserServices _userServices;

  AuthBloc(this._authServices, this._userServices) : super(AuthInitialState()) {
    on<CheckAuthenticationEvent>(_checkAuthentication);
    on<EmailSignInEvent>(emailSignIn);
    on<FacebookSignInEvent>(facebookSignIn);
    on<GoogleSignInEvent>(googleSignIn);
    on<EmailSignUpEvent>(emailSignUp);
    on<FacebookSignUpEvent>(_facebookSignUp);
    on<GoogleSignUpEvent>(_googleSignUp);
  }

  Future<void> _checkAuthentication(
      CheckAuthenticationEvent event, Emitter<AuthState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    if (await UserLocalServices.isUserLoggedIn()) {
      UserModel? loggedUserData = await UserLocalServices.getLoggedUserData();
      loggedUserData != null
          ? emit(AuthenticatedState(loggedUserDate: loggedUserData))
          : emit(UnAuthenticatedState());
    } else {
      emit(UnAuthenticatedState());
    }
  }

  /// Sign up Bloc
  Future<void> emailSignIn(
      EmailSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SigningInState(signingInMessage: 'Signing In.....'));
      await _authServices.firebaseEmailSignIn(
          emailId: event.email, password: event.password);
      final user = await _userServices.getUser(userId: event.email);
      emit(SignedInSuccessState(
        successMessage: event.email,
        user: user,
      ));
    } catch (e) {
      emit(SignedInFailedState(failureMessage: '$e'));
    }
  }

  Future<void> facebookSignIn(
      FacebookSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SigningInState(signingInMessage: 'Signing In.....'));
      final UserCredential loggedInUsedData =
          await _authServices.firebaseFacebookSignIn();
      final user = await _userServices.getUser(
          userId: loggedInUsedData.additionalUserInfo!.profile.toString());
      emit(SignedInSuccessState(successMessage: "", user: user));
    } catch (e) {
      emit(SignedInFailedState(failureMessage: 'Facebook sign up error$e'));
    }
  }

  Future<void> googleSignIn(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SigningInState(signingInMessage: 'Signing In.....'));
      UserCredential userCredential =
          await _authServices.firebaseGoogleSignIn();
      String emailId = userCredential.user!.email!;
      final user = await _userServices.getUser(userId: emailId);
      emit(SignedInSuccessState(successMessage: emailId, user: user));
    } catch (e) {
      emit(SignedInFailedState(failureMessage: 'Google sign up error$e'));
    }
  }

  /// Sign in Bloc

  Future<void> emailSignUp(
      EmailSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SigningUpState(signingUpMessage: 'Signing Up.....'));
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

  Future<void> _facebookSignUp(
      FacebookSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SigningUpState(signingUpMessage: 'Signing Up.....'));

      // emit(SignedUpSuccessState(
      //     successMessage: 'Signed up as ${userData.userName}', user: userData));
    } catch (e) {
      emit(SignedUpFailedState(signingUpFailureMessage: e.toString()));
    }
  }

  Future<void> _googleSignUp(
      GoogleSignUpEvent event, Emitter<AuthState> emit) async {
    try {
      emit(SigningUpState(signingUpMessage: 'Signing Up.....'));
      UserCredential userCredential =
          await _authServices.firebaseGoogleSignIn();
      String emailId = userCredential.user!.email!;
      await _userServices.addUser(
          userDate: UserModel(
              userName: emailId,
              userId: emailId,
              loginType: "Google",
              userProfileImage: ""));
      final UserModel userData = await _userServices.getUser(userId: emailId);
      emit(SignedUpSuccessState(
          successMessage: 'Signed up as ${userData.userName}', user: userData));
    } catch (e) {
      emit(SignedUpFailedState(signingUpFailureMessage: e.toString()));
    }
  }
}

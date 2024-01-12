import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<EmailSignInEvent>(emailSignIn);
    on<FacebookSignInEvent>(facebookSignIn);
    on<GoogleSignInEvent>(googleSignIn);
    on<EmailSignUpEvent>(_onSignUp);
  }
}

/// Sign up Bloc

Future<void> emailSignIn(
    EmailSignInEvent event, Emitter<AuthState> emit) async {
  try {
    emit(const SigningInState(signingInMessage: 'Signing In.....'));
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email, password: event.password);
    // ToDo
    emit(SignedInSuccessState(successMessage: event.email));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      emit(const SignedInFailedState(failerMessage: 'user-not-found'));
    } else if (e.code == 'invalid-credential') {
      emit(const SignedInFailedState(failerMessage: 'Wrong Password'));
    } else {
      emit(SignedInFailedState(failerMessage: '$e'));
    }
  }
}

Future<OAuthCredential> makeFaceBookAuth() async {
  try {
    // Trigger the facebook authentication flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Processing the FB sign in Result
    if (loginResult.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);
      return facebookAuthCredential;
    } else {
      throw Exception("Failed authentication Facebook");
    }
  } catch (e) {
    rethrow;
  }
}

Future<void> facebookSignIn(
    FacebookSignInEvent event, Emitter<AuthState> emit) async {
  try {
    emit(const SigningInState(signingInMessage: 'Signing In.....'));

    // trying fb auth
    OAuthCredential fbAuthCredential = await makeFaceBookAuth();

    // Once signed in, making google sign up with firebase
    final UserCredential signedInFBCredential =
        await FirebaseAuth.instance.signInWithCredential(fbAuthCredential);

    emit(SignedInSuccessState(
        successMessage: signedInFBCredential.user!.displayName!));
  } catch (e) {
    emit(SignedInFailedState(failerMessage: 'Facebook sign up error$e'));
  }
}

Future<OAuthCredential> makeGoogleAuth() async {
  try {
    // Trigger the Google authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return credential;
  } catch (e) {
    rethrow;
  }
}

Future<void> googleSignIn(
    GoogleSignInEvent event, Emitter<AuthState> emit) async {
  try {
    emit(const SigningInState(signingInMessage: 'Signing In.....'));

    // trying google auth
    OAuthCredential googleAuthCredential = await makeGoogleAuth();

    // Once signed in, making google sign up with firebase
    UserCredential signedInGoogleCredential =
        await FirebaseAuth.instance.signInWithCredential(googleAuthCredential);

    emit(SignedInSuccessState(
        successMessage: signedInGoogleCredential.user!.displayName!));
  } catch (e) {
    emit(SignedInFailedState(failerMessage: 'Google sign up error$e'));
  }
}

/// Sign up Bloc

Future<void> _onSignUp(EmailSignUpEvent event, Emitter<AuthState> emit) async {
  try {
    emit(const SigningUpState(signingUpMessage: 'Signing Up.....'));
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'nvbalaji6@gmail.com',
      password: '12345',
    );
    emit(SignedUpSuccessState(signingUpSuccessMessage: event.email));
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      emit(const SignedUpFailedState(
          signingUpFailureMessage: 'The password provided is too weak.'));
    } else if (e.code == 'email-already-in-use') {
      emit(const SignedUpFailedState(
          signingUpFailureMessage:
              'The account already exists for that email.'));
    }
  } catch (e) {
    print(e);
  }
}

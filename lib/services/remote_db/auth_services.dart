import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth firebaseInstance = FirebaseAuth.instance;

  Exception handleFirebaseException(e) {
    switch (e) {
      case 'user-not-found':
        return Exception('user-not-found');
      case 'invalid-credential':
        return Exception('user-not-found');
      case 'weak-password':
        return Exception('The password provided is too weak.');
      case 'email-already-in-use':
        return Exception('The account already exists for that email.');
      default:
        return Exception('Something went wrong');
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
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return credential;
    } catch (e) {
      rethrow;
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

  Future<void> firebaseEmailSignIn(
      {required String emailId, required String password}) async {
    try {
      await firebaseInstance.signInWithEmailAndPassword(
          email: emailId, password: password);
      // ToDo
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> firebaseGoogleSignIn() async {
    try {
      // trying google auth
      OAuthCredential googleAuthCredential = await makeGoogleAuth();

      // Once signed in, making google sign up with firebase
      UserCredential signedUserCredential = await FirebaseAuth.instance
          .signInWithCredential(googleAuthCredential);
      return signedUserCredential;
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> firebaseFacebookSignIn() async {
    try {
      // trying fb auth
      OAuthCredential fbAuthCredential = await makeFaceBookAuth();

      // Once signed in, making google sign up with firebase
      UserCredential signedUserCredential =
          await FirebaseAuth.instance.signInWithCredential(fbAuthCredential);
      return signedUserCredential;
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> firebaseEmailSignUp(
      {required String emailId, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailId,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw handleFirebaseException(e);
    } catch (e) {
      rethrow;
    }
  }

  firebaseGoogleSignUp() {}
  firebaseFacebookSignUp() {}
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
  }
}

Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
  try {
    emit(SigningInState());
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email, password: event.password);
    emit(SignedInSuccessState());
  } on FirebaseAuthException catch (e) {
    emit(SignedInFailedState());
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}

Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
  try {
    emit(SigningUpState());
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: 'nvbalaji6@gmail.com',
      password: '12345',
    );
    emit(SignedUpSuccessState());
  } on FirebaseAuthException catch (e) {
    emit(SignedUpFailedState());
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}

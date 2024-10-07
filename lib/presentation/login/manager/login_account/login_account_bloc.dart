import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_account_event.dart';
part 'login_account_state.dart';

class LoginAccountBloc extends Bloc<LoginAccountEvent, LoginAccountState> {
  LoginAccountBloc() : super(LoginAccountInitial()) {
    on<LoginAccountSubmitted>(
      (event, emit) async {
        emit(LoginAccountSubmitting());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginAccountSuccessful());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginAccountFailure('No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(LoginAccountFailure('Wrong password provided for that user.'));
          } else {
            emit(LoginAccountFailure(e.toString()));
          }
        }
      },
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'register_account_event.dart';
part 'register_account_state.dart';

class RegisterAccountBloc
    extends Bloc<RegisterAccountEvent, RegisterAccountState> {
  RegisterAccountBloc() : super(RegisterAccountInitial()) {
    on<RegisterAccountSubmitted>(
      (event, emit) async {
        print(event.username);
        print(event.email);
        print(event.password);
        emit(RegisterAccountSubmitting());
        if (event.username.isEmpty ||
            event.email.isEmpty ||
            event.password.isEmpty) {
          emit(RegisterAccountFailure("All fields are required."));
          return;
        }
        print('All fields are written');
        try {
          // Step 1: Create a new user with Firebase Authentication

          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          print('Added Credentials to FirebaseAuth');
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            emit(RegisterAccountFailure('The password provided is too weak.'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterAccountFailure(
                'The account already exists for that email.'));
          } else {
            emit(RegisterAccountFailure(e.toString()));
          }
        }

        try {
          CollectionReference users =
              FirebaseFirestore.instance.collection('User');
          print("Trying to add");
          await users.add({
            'username': event.username,
            'email': event.email,
            'password': event.password
          });
          print("User Created");
          emit(RegisterAccountSuccess());
        } catch (error) {
          emit(RegisterAccountFailure(error.toString()));
        }
      },
    );
  }
}

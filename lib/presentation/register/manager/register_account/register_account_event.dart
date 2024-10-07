part of 'register_account_bloc.dart';

@immutable
abstract class RegisterAccountEvent {}

class RegisterAccountSubmitted extends RegisterAccountEvent {
  String username;
  String email;
  String password;

  RegisterAccountSubmitted(
      {required this.username, required this.email, required this.password});
}

class RegisterAccountVerified extends RegisterAccountEvent {}

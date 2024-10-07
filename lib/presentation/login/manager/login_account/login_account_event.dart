part of 'login_account_bloc.dart';

@immutable
abstract class LoginAccountEvent {}


class LoginAccountSubmitted extends LoginAccountEvent{
  String email;
  String password;
  LoginAccountSubmitted ({required this.email, required this.password});
}
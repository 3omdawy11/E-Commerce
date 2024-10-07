part of 'login_account_bloc.dart';

@immutable
abstract class LoginAccountState {}

class LoginAccountInitial extends LoginAccountState {}

class LoginAccountSubmitting extends LoginAccountState{}

class LoginAccountSuccessful extends LoginAccountState{}

class LoginAccountFailure extends LoginAccountState{
  final String error;
  LoginAccountFailure(this.error);
}
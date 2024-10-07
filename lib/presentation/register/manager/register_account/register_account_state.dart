part of 'register_account_bloc.dart';

@immutable
abstract class RegisterAccountState {}

class RegisterAccountInitial extends RegisterAccountState {}

class RegisterAccountSubmitting extends RegisterAccountState{}

class RegisterAccountSuccess extends RegisterAccountState{}

class RegisterAccountFailure extends RegisterAccountState{
  final String error;
  RegisterAccountFailure(this.error);
}
class RegisterAccountVerifying extends RegisterAccountState{}
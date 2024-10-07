part of 'google_login_bloc.dart';

@immutable
abstract class GoogleLoginState {}

class GoogleLoginInitial extends GoogleLoginState {}

class GoogleLoginSubmitting extends GoogleLoginState {}
class GoogleLoginSuccessful extends GoogleLoginState {}
class GoogleLoginGetUsername extends GoogleLoginState {}
class GoogleLoginFailed extends GoogleLoginState {
  final String error;
  GoogleLoginFailed(this.error);
}
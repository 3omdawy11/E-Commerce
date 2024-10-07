part of 'google_login_bloc.dart';

@immutable
abstract class GoogleLoginEvent {}

class GoogleLoginSubmitted extends GoogleLoginEvent {
  String email;
  String password;
  GoogleLoginSubmitted({required this.email, required this.password});
}

class GoogleLoginUsernameSubmitted extends GoogleLoginEvent {
  String username;
  GoogleLoginUsernameSubmitted({required this.username});
}

part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsEvent {}

class LoadUserData extends UserDetailsEvent {}

class SaveUserData extends UserDetailsEvent {
  String username;
  String email;
  String firstName;
  String lastName;
  String location;
  Uint8List? profilePicture;
  SaveUserData(
      {required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.location,
      required this.profilePicture});
}
//
// class FirstNameChanged extends UserDetailsEvent {
//   String firstName;
//   FirstNameChanged(this.firstName);
// }
//
// class LastNameChanged extends UserDetailsEvent {
//   String lastName;
//   LastNameChanged(this.lastName);
// }
//
// class LocationChanged extends UserDetailsEvent {
//   String location;
//   LocationChanged(this.location);
// }
//
// class ProfilePictureChanged extends UserDetailsEvent {
//   Uint8List profilePicture;
//   ProfilePictureChanged(this.profilePicture);
// }

class RecoverPassword extends UserDetailsEvent {
  String email;
  RecoverPassword(this.email);
}

class SubmittedOTP extends UserDetailsEvent {
  String oneTimePin;
  SubmittedOTP(this.oneTimePin);
}

class SubmittedNewPassword extends UserDetailsEvent {
  String password;
  String confirmationPassword;
  SubmittedNewPassword(this.password, this.confirmationPassword);
}

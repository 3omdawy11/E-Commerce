part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsState {}

class UserInitial extends UserDetailsState {}

class UserLoaded extends UserDetailsState {
  String username;
  String email;
  String? firstName;
  String? lastName;
  String? location;
  Uint8List? profilePicture;

  UserLoaded(
      {required this.firstName,
      required this.lastName,
      required this.location,
      required this.profilePicture,
      required this.username,
      required this.email});
}

class SavingProfile extends UserDetailsState {}

class ReceivingEmail extends UserDetailsState {}

class EnterOTP extends UserDetailsState {}

class EmailSentSuccess extends UserDetailsState {}

class EmailSentFail extends UserError {
  EmailSentFail(super.error);
}

abstract class UserError extends UserDetailsState {
  final String error;

  UserError(this.error);
}

class UserLoadFail extends UserError {
  UserLoadFail(super.error);
}

class UserSaveFail extends UserError {
  UserSaveFail(super.error);
}

class OTPEnteredSuccess extends UserDetailsState {
  String message;
  OTPEnteredSuccess(this.message);
}

class OTPEnteredFail extends UserError {
  OTPEnteredFail(super.error);
}

class ChangePasswordSuccess extends UserDetailsState {
  String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordFail extends UserDetailsState {
  String message;
  ChangePasswordFail(this.message);
}

class Loading extends UserDetailsState {}

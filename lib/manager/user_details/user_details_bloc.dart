import 'package:bloc/bloc.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  // FOR EMAIL PURPOSES
  EmailOTP emailOTP = EmailOTP();
  Uint8List? profilePicture;
  UserDetailsBloc() : super(UserInitial()) {
    on<LoadUserData>((event, emit) async {
      print('Trying to get user data');
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(UserLoadFail("User is not signed in."));
        return;
      }
      String userId = currentUser.uid;
      print("User id is $userId");
      final storageRef = FirebaseStorage.instance.ref();

      try {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('User')
            .doc(userId)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          // Ensure username exists for image path
          if (userData.containsKey('username') &&
              userData['username'] != null) {
            try {
              final imageRef =
                  storageRef.child('${userData['username']}PP.jpg');
              // Try fetching image bytes from Firebase Storage
              profilePicture = await imageRef.getData();

              if (profilePicture == null) {
                print(
                    "No profile picture found for user: ${userData['username']}");
              }
            } catch (e) {
              if (e is FirebaseException && e.code == 'object-not-found') {
                print(
                    "No profile picture found for user: ${userData['username']}");
                profilePicture = null; // Set to null if no image is found
              } else {
                print("Failed to fetch profile picture: $e");
                profilePicture = null; // Set to null if another error
              }
            }
          } else {
            print("Username not found for user profile picture path.");
            profilePicture = null; // Set to null if username is missing
          }

          print(userData['firstName'] ?? 'Add First Name');
          print(userData['lastName'] ?? 'Add Last Name');
          print(userData['location'] ?? 'Add Location');
          print(userData['username']);
          print(userData['email']);
          print(profilePicture);

          emit(
            UserLoaded(
              username: userData['firstName'],
              email: userData['email'],
              firstName: userData['lastName'] ?? '',
              lastName: userData['lastName'] ?? '',
              location: userData['location'] ?? '',
              profilePicture: profilePicture,
            ),
          );
          print("User Loaded Emitted");
        } else {
          emit(UserLoadFail("User data not found in the database."));
        }
      } catch (e) {
        emit(UserLoadFail("Failed to load user data: ${e.toString()}"));
      }
    });

    on<SaveUserData>((event, emit) async {
      print('Starting to Save');
      emit(SavingProfile());
      try {
        final storageRef = FirebaseStorage.instance.ref();
        final imageRef = storageRef.child("${event.username}PP.jpg");

        // Upload profile picture if it's provided
        if (event.profilePicture != null) {
          await imageRef.putData(event.profilePicture!);
        }

        String userId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('User').doc(userId).update({
          'firstName': event.firstName,
          'lastName': event.lastName,
          'location': event.location,
        });

        // Emit success state
        emit(UserLoaded(
            firstName: event.firstName,
            lastName: event.lastName,
            location: event.location,
            profilePicture: event.profilePicture,
            username: event.username,
            email: event.email));
        print("Profile saved successfully.");
      } catch (error) {
        print("Error while saving profile: $error");
        emit(UserSaveFail(error.toString()));
      }
    });

    on<RecoverPassword>((event, emit) async {
      emit(ReceivingEmail());

      print("Verifying email: ${event.email}");

      try {
        // Query Firestore to check if the email exists in the 'users' collection
        var querySnapshot = await FirebaseFirestore.instance
            .collection(
                'User') // Replace 'User' with your actual collection name
            .where('email', isEqualTo: event.email)
            .get();

        // If the query result is not empty, the email exists
        if (querySnapshot.docs.isNotEmpty) {
          print('Email found in Firestore: ${event.email}');

          // Configure the OTP settings
          EmailOTP.config(
            appName: 'Nike',
            otpType: OTPType.numeric,
            expiry: 30000,
            emailTheme: EmailTheme.v6,
            appEmail: 'mohamedkilany070@gmail.com',
            otpLength: 4,
          );

          // Send OTP
          bool isSent = await EmailOTP.sendOTP(email: event.email);
          if (isSent) {
            emit(EmailSentSuccess());
          } else {
            emit(EmailSentFail('Failed to send email. Please try again.'));
          }
        } else {
          emit(EmailSentFail('Email does not exist in the database.'));
          print('Email not found: ${event.email}');
        }
      } catch (e) {
        emit(EmailSentFail('An error occurred: ${e.toString()}'));
        print('Error: ${e.toString()}');
      }
    });

    on<SubmittedOTP>((event, emit) async {
      if (event.oneTimePin == EmailOTP.getOTP()) {
        emit(OTPEnteredSuccess('Password Changed Successfully'));
      } else {
        emit(OTPEnteredFail('Wrong OTP'));
      }
    });

    on<SubmittedNewPassword>((event, emit) async {
      emit(Loading());

      if (event.password == event.confirmationPassword) {
        try {
          User? currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            await currentUser.updatePassword(event.password);
            emit(ChangePasswordSuccess('Password Changed Successfully'));
          } else {
            emit(ChangePasswordFail('User is not signed in.'));
          }
        } catch (e) {
          emit(
              ChangePasswordFail('Failed to update password: ${e.toString()}'));
        }
      } else {
        emit(ChangePasswordFail('Passwords do not match'));
      }
    });
  }
}

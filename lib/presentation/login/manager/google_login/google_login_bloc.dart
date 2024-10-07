import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'google_login_event.dart';
part 'google_login_state.dart';

class GoogleLoginBloc extends Bloc<GoogleLoginEvent, GoogleLoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  GoogleLoginBloc() : super(GoogleLoginInitial()) {
    // Handle Google Login Submission
    on<GoogleLoginSubmitted>((event, emit) async {
      try {
        emit(GoogleLoginSubmitting());
        print("Trying to log in using Google");

        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);

        // Check if it's the user's first time logging in
        final user = _auth.currentUser;
        String uid = user!.uid;

        CollectionReference users = FirebaseFirestore.instance.collection('User');
        DocumentSnapshot userDoc = await users.doc(uid).get();

        if (!userDoc.exists) {
          print("First time to log in");
          emit(GoogleLoginGetUsername());
        } else {
          print("Logged in successfully");
          emit(GoogleLoginSuccessful());
        }




      } catch (e) {
        print("Failed to log in: $e");
        emit(GoogleLoginFailed(
            e.toString()));
      }
    });

    // Handle Username Submission
    on<GoogleLoginUsernameSubmitted>((event, emit) async {
      try {
        emit(GoogleLoginSubmitting());

        if (event.username.isEmpty) {
          emit(GoogleLoginFailed("Username cannot be empty"));
          return;
        }

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(GoogleLoginFailed("User is not logged in."));
          return;
        }

        // Update Firebase user profile with the username
        await user.updateDisplayName(event.username);

        // Save the username and email to Firestore
        String uid = user.uid;
        print("Creating user ID ${uid}");
        CollectionReference users =
            FirebaseFirestore.instance.collection('User');

        await users.doc(uid).set({
          'username': event.username,
          'email': user.email,
        });

        emit(GoogleLoginSuccessful());
      } catch (e) {
        emit(GoogleLoginFailed("Failed to update username."));
      }
    });
  }
}

// Method to handle Google Sign-In
// Future<UserCredential> signInWithGoogle() async {
//   print("Trying to get google user");
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//   // Handle user canceling the sign-in flow
//   if (googleUser == null) {
//     throw Exception('Google sign-in was canceled');
//   }
//   print("After first if condition");
//   print("Google user obtained: ${googleUser?.displayName}");
//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//
//   print("After googleAuth");
//   // Check for null auth credentials
//   if (googleAuth.accessToken == null || googleAuth.idToken == null) {
//     throw Exception('Google authentication failed');
//   }
//   print("After google Auth condition");
//   // Create a new credential and sign in
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth.accessToken,
//     idToken: googleAuth.idToken,
//   );
//   print("After Credentials submission");
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }

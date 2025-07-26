import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApi {
  final GoogleSignIn signIn;
  final FirebaseAuth auth;

  AuthApi(this.signIn, this.auth);

  Stream<User?> get authStateChanges => auth.authStateChanges();
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await signIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {}

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      // Sign in to Firebase with the credential
      return await auth.signInWithCredential(credential);
    } catch (e) {
      log("Google sign-in failed: $e");
      return null;
    }
  }

  bool isUserSignedIn() {
    final currentUser = auth.currentUser;
    if (currentUser == null) {
      return false;
    }
    return true;
  }

  Future<void> signOutUser() async {
    await signIn.signOut();
    await auth.signOut();
  }
}

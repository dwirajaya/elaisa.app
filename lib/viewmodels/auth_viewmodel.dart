import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return _getUserModel(userCredential.user, false, false);
    } catch (e) {
      // ignore: avoid_print
      print('Error signing in with Google: $e');
    }
    return null;
  }

  UserModel? _getUserModel(User? user, bool isAnonymous, bool isPremium) {
    if (user != null) {
      return UserModel(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        photoUrl: user.photoURL,
        isAnonymous: isAnonymous,
        isPremium: isPremium,
      );
    }
    return null;
  }

  Future<UserModel?> signInAnonymously() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      return _getUserModel(userCredential.user, true, false);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("Anonymous sign-in error");
    }
    return null;
  }

  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _getUserModel(userCredential.user, false, false);
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print('An error occurred during sign-in.');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

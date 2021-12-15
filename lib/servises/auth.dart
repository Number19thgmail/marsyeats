import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn(); //as Future<GoogleSignInAccount?>;
  if (googleUser != null) {
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    ) as GoogleAuthCredential;
    return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  }
  return null;
}

Future<User?> getUser() async {
  return (FirebaseAuth.instance.currentUser != null ? FirebaseAuth.instance.currentUser : await signInWithGoogle());
}

Future<User?> signOutGoogle() async {
  FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  return await signInWithGoogle();
}

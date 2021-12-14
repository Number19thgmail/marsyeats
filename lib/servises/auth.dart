import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<User?> signInWithGoogle() async {
  final GoogleSignInAccount googleUser = await (GoogleSignIn().signIn() as FutureOr<GoogleSignInAccount>);
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  ) as GoogleAuthCredential;
  return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
}

Future<User?> getUser() async {
  return (FirebaseAuth.instance.currentUser != null
      ? FirebaseAuth.instance.currentUser
      : signInWithGoogle()) as FutureOr<User?>;
}

void signOutGoogle() async {
  FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();
  await signInWithGoogle();
}

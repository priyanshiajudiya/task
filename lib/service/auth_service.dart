import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/model_class.dart';




//sign in with google

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  await GoogleSignIn().signOut();
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
  await googleUser?.authentication;
  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}


//store data in firebase
Future createuser(UserModal UserModal) async {
  final firestore =
  FirebaseFirestore.instance.collection("user").doc("${UserModal.uId}");
  await firestore.set(UserModal.toJson());
}

Future createmail(UserModal UserModal) async {
  final firestore =
  FirebaseFirestore.instance.collection("user").doc("${UserModal.uId}");
  await firestore.set(UserModal.toJson());
}


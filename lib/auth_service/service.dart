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

/*

 try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: t.text, password: t1.text);
                          widget.tabController.animateTo(2);

                          UserModal userModel = UserModal(
                            email: credential.user!.email,
                            userImage: credential.user!.photoURL,
                            name:a,
                            uId: credential.user!.uid,
                            phone: credential.user!.phoneNumber,
                          );

                          if (userModel.uId == credential.user!.uid) {
                            createmail(userModel);
                          }
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString("login", "Yes");

                          print(credential);
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: const Text(
                                  'wrong-password',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          }
                        }
 */

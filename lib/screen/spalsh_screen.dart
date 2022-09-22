import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/first.dart';
import 'package:task/model/model_class.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splash();
    tabController = TabController(vsync: this, length: 3);
  }

  Future splash() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return login(tabController);
      },
    ));
    share_pref.pref = await SharedPreferences.getInstance();
    if (share_pref.pref!.containsKey("login")) {
      tabController.animateTo(2);
    } else {
      tabController.animateTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:demo/screens/restepassword.dart';
// import 'package:demo/service/sprfrnce.dart';
// import 'package:demo/service/user_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Loginscrren extends StatefulWidget {
//   TabController tabController;
//
//   Loginscrren(this.tabController);
//
//   @override
//   State<Loginscrren> createState() => _LoginscrrenState();
// }
//
// class _LoginscrrenState extends State<Loginscrren> {
//   TextEditingController temail = TextEditingController();
//   TextEditingController tpassword = TextEditingController();
//   bool chack = false;
//   bool _isObscure = true;
//   String _character = "User";
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusManager.instance.primaryFocus?.unfocus();
//       },
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               // email
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: TextField(
//                   controller: temail,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'email',
//                     hintText: 'Enter Your email',
//                   ),
//                 ),
//               ),
//               //password
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: TextField(
//                   controller: tpassword,
//                   obscureText: _isObscure,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'password',
//                     hintText: 'Enter Your password',
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         setState(() {
//                           _isObscure = !_isObscure;
//                         });
//                       },
//                       icon: Icon(
//                         _isObscure ? Icons.visibility : Icons.visibility_off,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               //forget password
//               TextButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(
//                       builder: (context) {
//                         return restPassword();
//                       },
//                     ));
//                   },
//                   child: Text("forgot password")),
//               // login button
//               ElevatedButton(
//                   onPressed: () async {
//                     FocusManager.instance.primaryFocus?.unfocus();
//
//                     bool emailValid = RegExp(
//                         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                         .hasMatch(temail.text);
//
//                     // String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                     // RegExp regExp = new RegExp(p);
//
//                     if (emailValid == false && tpassword.text.length < 8) {
//                       String errorA = "email and password not vaild";
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(errorA),
//                           action: SnackBarAction(
//                             label: 'Action',
//                             onPressed: () {},
//                           ),
//                         ),
//                       );
//                     } else if (emailValid == false) {
//                       String errorB = "email is Not Vaild!";
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(errorB),
//                           action: SnackBarAction(
//                             label: 'Action',
//                             onPressed: () {},
//                           ),
//                         ),
//                       );
//                     } else if (tpassword.text.length < 8) {
//                       String errorC = "Minum 8 lettor in Password";
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(errorC),
//                           action: SnackBarAction(
//                             label: 'Action',
//                             onPressed: () {},
//                           ),
//                         ),
//                       );
//                     } else {
//                       CircularProgressIndicator();
//                       String waiting = "some seconds wait";
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(waiting),
//                           action: SnackBarAction(
//                             label: 'Action',
//                             onPressed: () {},
//                           ),
//                         ),
//                       );
//                     }
//
//                     try {
//                       final credential = await FirebaseAuth.instance
//                           .createUserWithEmailAndPassword(
//                         email: temail.text,
//                         password: tpassword.text,
//                       );
//                       print(credential);
//                       widget.tabController.animateTo(2);
//
//                       SherdPrefe.prefs = await SharedPreferences.getInstance();
//                       await SherdPrefe.prefs!.setString("login", "yes");
//
//                       UserModal usermodel = UserModal(
//                         email: temail.text,
//                         password: tpassword.text,
//                         uId: credential.user!.uid,
//                         name: _character,
//                       );
//                       createUsers(usermodel);
//                       temail.clear();
//                       tpassword.clear();
//                     } on FirebaseAuthException catch (e) {
//                       if (e.code == 'weak-password') {
//                         print('The password provided is too weak.');
//                       } else if (e.code == 'email-already-in-use') {
//                         print('The account already exists for that email.');
//                         try {
//                           final credential = await FirebaseAuth.instance
//                               .signInWithEmailAndPassword(
//                               email: temail.text, password: tpassword.text);
//
//                           UserModal usermodel = UserModal(
//                             email: temail.text,
//                             password: tpassword.text,
//                             uId: credential.user!.uid,
//                             name: _character,
//
//                           );
//                           if (usermodel.uId == credential.user!.uid) {
//                             createUsers(usermodel);
//                           }
//
//                           SherdPrefe.prefs =
//                           await SharedPreferences.getInstance();
//                           await SherdPrefe.prefs!.setString("login", "yes");
//                           temail.clear();
//                           tpassword.clear();
//                           widget.tabController.animateTo(2);
//                           print(credential);
//                         } on FirebaseAuthException catch (e) {
//                           if (e.code == 'user-not-found') {
//                             print('No user found for that email.');
//                           } else if (e.code == 'wrong-password') {
//                             print('Wrong password provided for that user.');
//
//                             String errorD =
//                                 "Wrong password provided for that user.";
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text(errorD),
//                                 action: SnackBarAction(
//                                   label: 'Action',
//                                   onPressed: () {},
//                                 ),
//                               ),
//                             );
//                           }
//                         }
//                       }
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                   child: const Text("Login")),
//               //google login
//               ElevatedButton(
//                   onPressed: () async {
//                     FocusManager.instance.primaryFocus?.unfocus();
//
//                     UserCredential? login = await signInWithGoogle();
//
//                     if (login.user != null) {
//                       UserModal userModal = UserModal(
//                         email: login.user!.email,
//                         name: login.user!.displayName,
//                         phone: login.user!.phoneNumber,
//                         uId: login.user!.uid,
//                         userImage: login.user!.photoURL,
//                       );
//                       createUser(userModal);
//                       widget.tabController.animateTo(2);
//                       SherdPrefe.prefs = await SharedPreferences.getInstance();
//                       await SherdPrefe.prefs!.setString("login", "yes");
//                     } else {
//                       CircularProgressIndicator();
//                     }
//                     print("Login");
//                   },
//                   child: Text("Google_Sign")),
//               //Admin / User
//
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Radio(
//                                 value: "Admin",
//                                 groupValue: _character,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _character = value.toString();
//                                   });
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: Text("Admin"),
//                             ),
//                             Expanded(
//                               child: Radio(
//                                 value: "User",
//                                 groupValue: _character,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _character = value.toString();
//                                   });
//                                 },
//                               ),
//                             ),
//                             Expanded(
//                               child: Text("User"),
//                             )
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   //google sign function
//   Future<UserCredential> signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication? googleAuth =
//     await googleUser?.authentication;
//
//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth?.accessToken,
//       idToken: googleAuth?.idToken,
//     );
//
//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }
//
// //firbase sore in data google
//   Future createUser(UserModal userModal) async {
//     final firestore =
//     FirebaseFirestore.instance.collection("user").doc("${userModal.uId}");
//
//     await firestore.set(userModal.toJson());
//   }
//
//   Future createUsers(UserModal usermodel) async {
//     final firestore =
//     FirebaseFirestore.instance.collection("user").doc(usermodel.uId);
//
//     final json = usermodel.toJson();
//
//     await firestore.set(json);
//   }
// }

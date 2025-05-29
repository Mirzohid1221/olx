import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Enter.dart';

class AuthServise {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static bool isLoggerIn() {
    final User? firebaseUser = _auth.currentUser;
    return firebaseUser != null;
  }

  static Future<User?> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuth Error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Other Error: $e');
      return null;
    }
  }

  static Future<User?> signUP(
      String fullname,
      String email,
      String password,
      ) async {
    var result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;
    return user;
  }

  static void signOut(BuildContext context) {
    _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          return Enter();
        },
      ),
    );
  }
}

// static Future<User?> signUp(String email, String password, String nickname) async {
//   try {
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//
//     User? user = userCredential.user;
//
//     if (user != null) {
//       await _firestore.collection('users').doc(user.uid).set({
//         'nickname': nickname,
//         'email': email,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//
//     return user;
//   } on FirebaseAuthException catch (e) {
//     print('FirebaseAuth Error: ${e.code} - ${e.message}');
//     return null;
//   } catch (e) {
//     print('Other Error: $e');
//     return null;
//   }
// }

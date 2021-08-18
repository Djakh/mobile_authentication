import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_authentication/repository/user_repository.dart';

class FireBaseUserRepository extends UserRepository {
  /// Firebase authentication repository
  const FireBaseUserRepository();

  @override
  String get signedEmail => FirebaseAuth.instance.currentUser!.email ?? "-";

  @override
  Future<bool> login(String userName, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userName, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      print('error was thrown DJAKHHHHH');
      return false;
    }
  }

  @override
  Future<bool> register(String userName, String password)async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userName, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  @override
  Future<void> logOut() => FirebaseAuth.instance.signOut();


}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_authentication/models/auth/email.dart';

class UsageAuthProvider extends ChangeNotifier {
  // Usage example of the EmailUser class
  Future<UserCredential?> toRegister(String email, String password) async {
    UserCredential? user;

    try {
      final auth = EmailUser(email: email, password: password);
       user = await auth.register();
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        print("Error: Weal password");
      }

      if (e.code == "email-already-in-use") {
        print("Error: email already in use");
      }
    } catch (e) {
      print("Whoops, something's gone wrong :(");
    }
    return user;
  }
}

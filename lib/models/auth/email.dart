import 'package:mobile_authentication/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailUser implements UserRepository<UserCredential> {
  final String email;
  final String password;

  EmailUser({required this.email, required this.password});

  @override
  Future<UserCredential> register() async {
    final auth = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
// We'll deal with this later
await auth.user!.sendEmailVerification();
    return auth;
  }

  @override
  Future<UserCredential> signIn() async => await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> signOut() => FirebaseAuth.instance.signOut();


}

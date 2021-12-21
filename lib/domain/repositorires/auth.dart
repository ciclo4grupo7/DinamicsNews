import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthInterface {
  Future<bool> signUp(
      {required String name, required String email, required String password});

  Future<bool> signIn(
      {required String email, required String password});

  Future<bool> signInWithGoogle();

  Future<bool> signOut();

  static Stream<User?> get authStream =>
      FirebaseAuth.instance.authStateChanges();
}

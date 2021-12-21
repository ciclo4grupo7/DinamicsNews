import 'package:dynamics_news/data/repositories/google_auth.dart';
import 'package:dynamics_news/data/repositories/password_auth.dart';

class AuthManagement {
  PasswordAuth auth = PasswordAuth();
  GoogleAuth googleAuth = GoogleAuth();

  AuthManagement({required this.auth, required this.googleAuth});

  Future<bool> signIn({required String email, required String password}) async {
    try {
      return await auth.signIn(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      return await googleAuth.signInWithGoogle();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      return await auth.signUp(name: name, email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}

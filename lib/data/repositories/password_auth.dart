import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/repositorires/auth.dart';

class PasswordAuth implements AuthInterface {
  @override
  Future<bool> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          "Usuario no encontrado",
          "No se encontró un usuario que use ese email.",
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          "Contraseña equivocada",
          "La contraseña proveida por el usuario no es correcta.",
        );
      }
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Contraseña insegura",
          "La seguridad de la contraseña es muy débil",
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Email inválido",
          "Ya existe un usuario con este correo electrónico.",
        );
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // We throw an error if someone calls SignInWithGoogle, member of AuthInterface
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

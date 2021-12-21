import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dynamics_news/data/repositories/password_auth.dart';

class MockAuth extends Mock implements PasswordAuth {
  @override
  Future<bool> signIn({required String email, required String password}) async {
    final emailVal = "barry.allen@example.com" == email;
    final passwordVal = "SuperSecretPassword!" == password;
    return emailVal && passwordVal;
  }

  @override
  Future<bool> signOut() async {
    return true;
  }

  @override
  Future<bool> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final emailVal = email.contains("@") && email.contains(".co");
    final passwordVal = password.length > 6;
    return emailVal && passwordVal;
  }
}

void main() {
  late MockAuth auth;

  setUp(() {
    auth = MockAuth();
  });

  test('auth-signin', () async {
    final result = await auth.signIn(
        email: "barry.allen@example.com", password: "SuperSecretPassword!");
    expect(result, true);
  });

  test('auth-signup', () async {
    final result = await auth.signUp(
        name: "Barry Allen",
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!");
    expect(result, true);
  });

  test('auth-signout', () async {
    final result = await auth.signOut();
    expect(result, true);
  });
}

class Auth {
  signIn({required String email, required String password}) {}

  signUp(
      {required String name,
      required String email,
      required String password}) {}

  signOut() {}
}

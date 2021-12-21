import 'package:flutter_test/flutter_test.dart';
import 'package:dynamics_news/data/repositories/google_auth.dart';
import 'package:dynamics_news/data/repositories/password_auth.dart';
import 'package:dynamics_news/domain/use_cases/auth_management.dart';

void main() {
  late AuthManagement management;

  setUp(() {
    management = AuthManagement(
      auth: PasswordAuth(),
      googleAuth: GoogleAuth(),
    );
  });
  // AuthManagement uses Auth for management
  // Contrast method result with expected value
  test(
    "SignIn valid",
    () async {
      expect(
          await management.signIn(
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!"),
          true);
    },
  );

  test(
    "SignIn invalid",
    () async {
      expect(
          await management.signIn(
              email: "user@test.com", password: "123456"),
          false);
    },
  );

  test(
    "SignUp valid",
    () async {
      expect(
          await management.signUp(
              name: "User",
              email: "barry.allen@example.com",
              password: "SuperSecretPassword!"),
          true);
    },
  );

  test(
    "SignUp invalid",
    () async {
      expect(
          await management.signUp(
            name: "User",
            email: "usertest.xys",
            password: "1456",
          ),
          false);
    },
  );

  test(
    "SignOut validation",
    () async {
      expect(await management.signOut(), true);
    },
  );
}

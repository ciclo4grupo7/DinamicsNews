import 'package:flutter/material.dart';
import 'package:dynamicsnews/Screens/Login/login_screen.dart';
import 'package:dynamicsnews/Screens/Signup/components/background.dart';
import 'package:dynamicsnews/Screens/Signup/components/or_divider.dart';
import 'package:dynamicsnews/Screens/Signup/components/social_icon.dart';
import 'package:dynamicsnews/components/already_have_an_account_acheck.dart';
import 'package:dynamicsnews/components/rounded_button.dart';
import 'package:dynamicsnews/components/rounded_input_field.dart';
import 'package:dynamicsnews/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Registrese",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo.png",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Nombre de Usuario",
              onChanged: (value) {},
            ),
            RoundedInputField(
              hintText: "Correo Electronico",
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "Registrarse",
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            //OrDivider(),
          ],
        ),
      ),
    );
  }
}

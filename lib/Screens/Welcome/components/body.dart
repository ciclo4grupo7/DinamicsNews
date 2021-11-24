import 'package:flutter/material.dart';
import 'package:dynamicsnews/Screens/Login/login_screen.dart';
import 'package:dynamicsnews/Screens/Signup/signup_screen.dart';
import 'package:dynamicsnews/Screens/Welcome/components/background.dart';
import 'package:dynamicsnews/components/rounded_button.dart';
import 'package:dynamicsnews/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "BIENVENIDOS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  //backgroundColor: Colors.lightBlue[200],
                  color: Colors.lightBlueAccent),
            ),
            SizedBox(height: size.height * 0.05),
            Image.asset(
              "assets/images/logo1.png",
              height: size.height * 0.45,
            ),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "Iniciar Sesión",
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
            RoundedButton(
              text: "¿Aun no tienes cuenta? Registrate!",
              color: kPrimaryLightColor,
              textColor: Colors.black,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

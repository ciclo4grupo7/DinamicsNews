import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/controllers/connectivity.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class WelcomeScreen extends StatefulWidget {
  final VoidCallback onViewSwitchButton;
  final VoidCallback onViewSwitchHome;

  const WelcomeScreen({Key? key, required this.onViewSwitchButton, required this.onViewSwitchHome}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<WelcomeScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final connectivityController = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "BIENVENIDOS",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/logo1.png",
              height: size.height * 0.35,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: ElevatedButton(
                    child: const Text("Iniciar Sesión",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    onPressed: widget.onViewSwitchButton,
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(0, 60)),  //El ancho de deja en 0 porque el "expanded" lo define.
                  ),
                ),
              )
            ],
          ),
          TextButton(
            key: const Key("toSignUpButton"),
            child: Text(
              "¿No tienes cuenta? Registrate!",  
              style: Theme.of(context).textTheme.bodyText1,
            ),
            onPressed: widget.onViewSwitchHome,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                      // ignore: prefer_const_constructors
                      icon: FaIcon(
                              FontAwesomeIcons.google,
                              color: Colors.red,
                            ),
                      onPressed: () => controller.manager.signInWithGoogle(),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

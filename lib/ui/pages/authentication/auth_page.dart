import 'package:flutter/material.dart';
import 'package:dynamics_news/ui/pages/authentication/welcome/welcome_screen.dart';
import 'package:dynamics_news/ui/pages/authentication/login/login_screen.dart';
import 'package:dynamics_news/ui/pages/authentication/signup/singup_screen.dart';
import 'package:dynamics_news/ui/widgets/appbar_home.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AuthenticationPage> {
  String _title = "";
  Widget? _content;

  void _inicio() {
      _onItemTapped(1);
    }

  // NavBar action
  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 1:
          _title = "Dynamics News";
          _content = WelcomeScreen(
            onViewSwitchButton: () => _onItemTapped(2),
            onViewSwitchHome: () => _onItemTapped(3),
          );
          break;
        case 2:
          _title = "Inicio de Sesión";
          _content = LoginScreen(
            onViewSwitchText: () => _onItemTapped(3),
            onViewSwitchHome: () => _inicio(),
          );
          break;
        case 3:
          _title = "Registro";
          _content = SignUpScreen(
            onViewSwitchText: () => _onItemTapped(2),
            onViewSwitchHome: () => _inicio(),
          );
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _title = "Dynamics News";
    _content = WelcomeScreen(onViewSwitchButton: () => _onItemTapped(2), onViewSwitchHome: () => _onItemTapped(3));
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarHome(
        tile: Text(_title),
        context: context,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: _content,
          ),
        ),
      ),
      floatingActionButton: null
    );
  }
}

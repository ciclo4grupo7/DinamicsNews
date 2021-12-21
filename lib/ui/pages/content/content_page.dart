// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/controllers/ui.dart';
import 'package:dynamics_news/ui/pages/content/location/location_screen.dart';
import 'package:dynamics_news/ui/pages/content/wnews/wnews_screen.dart';
import 'package:dynamics_news/ui/pages/content/states/states_screen.dart';
import 'package:dynamics_news/ui/pages/content/news/news_screen.dart';
import 'package:dynamics_news/ui/pages/content/chats/chats_screen.dart';
import 'package:dynamics_news/ui/widgets/appbar.dart';

class ContentPage extends StatelessWidget {
  int? indice;
  String? userB;
  bool ind1 = true;
  bool ind2 = true;
  ContentPage({Key? key, int? indice, String? userB}) :super(key: key) {
    this.indice = indice;
    this.userB = userB;
  }

  
// View content
  Widget _getScreen(int index) {
    print("_getScreen.index: " + index.toString());
    print("_getScreen.indice: " + indice.toString());
    if (ind1 && indice != null) {
      index = indice!;
      ind1 = false;
    }
    switch (index) {
      case 1:
        //Noticias
        return const NewsScreen();
      case 2:
        //NoticiasWeb
        return const WNewsScreen();
      case 3:
        //Localización
        return LocationScreen();
      case 4:
        //Chat
        return const ChatsScreen();
      default:
        //Estados
        return const StatesScreen();
    }
  }



  Widget _getTitle(int index) {
    String titChat = "Chat";
    print("_getScreen.index: " + index.toString());
    print("_getScreen.indice: " + indice.toString());
    if (ind2 && indice != null) {
      print("userB: " + userB!);
      index = indice!;
      titChat = 'Chat: ' + userB!;
      ind2 = false;
    }
    print("titChat: " + titChat);
    switch (index) {
      case 1:
        return const Text('Noticias');
      case 2:
        return const Text('NoticiasWeb');
      case 3:
        return const Text('Localización');
      case 4:
        return Text(titChat);
      default:
        return const Text('Estados');
    }
  }


  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    // Dependency injection: State management controller
    final UIController controller = Get.find<UIController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        controller: controller,
        picUrl: 'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
        //tile: const Text("Dynamics News"),
        tile: Obx(() => _getTitle(controller.reactiveScreenIndex.value)),
        onSignOff: () {
          authController.manager.signOut();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Obx(() => _getScreen(controller.reactiveScreenIndex.value)),
          ),
        ),
      ),
      // Content screen navbar
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.lightbulb_outline_rounded,
                  key: Key("statesSection"),
                ),
                label: 'Estados',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.group_outlined,
                  key: Key("socialSection"),
                ),
                label: 'Noticias',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.public_outlined,
                  key: Key("offersSection"),
                ),
                label: 'Noticias-Web',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.place_outlined,
                  key: Key("locationSection"),
                ),
                label: 'Ubicación',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.chat_bubble_outline,
                ),
                label: 'Chat',
              ),
            ],
            currentIndex: controller.screenIndex,
            onTap: (index) {
              controller.screenIndex = index;
            },
          )),
    );
  }
}

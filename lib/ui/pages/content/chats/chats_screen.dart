// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/models/user_chat.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/controllers/connectivity.dart';
import 'package:dynamics_news/domain/use_cases/chats_management.dart';
import 'package:dynamics_news/ui/pages/content/chats/widgets/new_chat.dart';
import 'package:dynamics_news/ui/pages/content/chats/widgets/chat_card.dart';

class ChatsScreen extends StatefulWidget {
  // ChatsScreen empty constructor
  const ChatsScreen({Key? key}) : super(key: key);
  // String? userB;
  // ChatsScreen({Key? key, String? userB}) :super(key: key) {
  //   this.userB = userB;
  // }


  @override
  _State createState() => _State();
}

class _State extends State<ChatsScreen> {
  late final ChatsManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> chatsStream;
  late ConnectivityController connectivityController;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    manager = ChatsManager();
    chatsStream = manager.getJobsStream();
    print("chatsStream.length: " + chatsStream.length.toString());
    
    connectivityController = Get.find<ConnectivityController>();
    authController = Get.find<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: chatsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final items = manager.extractChats(snapshot.data!);
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      UserChat chat = items[index];
                      return ChatCard(
                        title: chat.name.split(" ")[0],
                        content: chat.message,
                        picUrl: chat.picUrl,
                        onChat: () {},
                        onTap: () {
                          // If the chat email is the same as the current user,
                          // we know that the user is the owner of that chat.
                          if (chat.email == authController.currentUser?.email) {
                            Get.dialog(
                              Chat(
                                manager: manager,
                                userChat: chat,
                              ),
                            );
                          } else {
                            Get.snackbar(
                              "No Autorizado",
                              "No puedes editar esta noticia debido a que fue enviada por otro usuario.",
                            );
                          }
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Something went wrong: ${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (connectivityController.connected) {
            Get.dialog(
              Chat(
                manager: manager,
              ),
            );
          } else {
            Get.snackbar(
              "Error de conectividad",
              "No se encuentra conectado a internet.",
            );
          }
        },
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );
  }
}

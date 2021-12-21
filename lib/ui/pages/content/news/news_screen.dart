// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/models/user_anew.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/controllers/connectivity.dart';
import 'package:dynamics_news/domain/use_cases/news_management.dart';
import 'package:dynamics_news/ui/pages/content/news/widgets/new_anew.dart';
import 'package:dynamics_news/ui/pages/content/news/widgets/anew_card.dart';

class NewsScreen extends StatefulWidget {
  // NewsScreen empty constructor
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<NewsScreen> {
  late final NewsManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> newsStream;
  late ConnectivityController connectivityController;
  late AuthController authController;

  @override
  void initState() {
    super.initState();
    manager = NewsManager();
    newsStream = manager.getJobsStream();
    print("newsStream.length: " + newsStream.length.toString());
    
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
              stream: newsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final items = manager.extractNews(snapshot.data!);
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      UserANew anew = items[index];
                      return ANewCard(
                        title: "Noticia:" + anew.title,
                        content: "Contenido: " + anew.message,
                        picUrl: anew.picUrl,
                        onANew: () {},
                        onTap: () {
                          // If the anew email is the same as the current user,
                          // we know that the user is the owner of that anew.
                          if (anew.email == authController.currentUser?.email) {
                            Get.dialog(
                              ANews(
                                manager: manager,
                                userANew: anew,
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
              ANews(
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

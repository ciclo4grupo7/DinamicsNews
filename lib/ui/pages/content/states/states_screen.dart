import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/models/user_status.dart';
import 'package:dynamics_news/domain/use_cases/controllers/connectivity.dart';
import 'package:dynamics_news/domain/use_cases/status_management.dart';
import 'package:dynamics_news/ui/pages/content/states/widgets/new_state.dart';
import 'widgets/state_card.dart';

class StatesScreen extends StatefulWidget {
  // StatesScreen empty constructor
  const StatesScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<StatesScreen> {
  late final StatusManager manager;
  late Stream<QuerySnapshot<Map<String, dynamic>>> statusesStream;
  late ConnectivityController connectivityController;

  @override
  void initState() {
    super.initState();
    manager = StatusManager();
    statusesStream = manager.getStatusesStream();
    connectivityController = Get.find<ConnectivityController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: statusesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.hasData) {
                  final items = manager.extractStatuses(snapshot.data!);
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      UserStatus status = items[index];
                      return StateCard(
                        title: status.name,
                        content: status.message,
                        picUrl: status.picUrl,
                        onDelete: () {
                          manager.removeStatus(status);
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
              PublishDialog(
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

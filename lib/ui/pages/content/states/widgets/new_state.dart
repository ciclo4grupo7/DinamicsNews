import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/models/user_status.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/status_management.dart';

class PublishDialog extends StatefulWidget {
  final StatusManager manager;

  const PublishDialog({Key? key, required this.manager}) : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<PublishDialog> {
  late AuthController controller;
  late bool _buttonDisabled;
  late TextEditingController stateController;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    _buttonDisabled = false;
    stateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Publicar Estado",
              style: Theme.of(context).textTheme.headline2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                controller: stateController,
                keyboardType: TextInputType.multiline,
                // dynamic text lines
                maxLines: null,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Estado',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Publicar"),
                    onPressed: _buttonDisabled
                        ? null
                        : () {
                            setState(() {
                              _buttonDisabled = true;
                              User user = controller.currentUser!;
                              UserStatus status = UserStatus(
                                //picUrl: user.photoURL!,
                                picUrl: user.photoURL??'',
                                //name: user.displayName!,
                                name: user.displayName??user.email!.split('@')[0],
                                email: user.email!,
                                message: stateController.text,
                              );
                              widget.manager.sendStatus(status).then(
                                    (value) => Get.back(),
                                  );
                            });
                          },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    stateController.dispose();
    super.dispose();
  }
}

// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_is_empty, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/models/user_chat.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/chats_management.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Chat extends StatefulWidget {
  final ChatsManager manager;
  final UserChat? userChat;

  const Chat({Key? key, required this.manager, this.userChat})
      : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<Chat> {
  late AuthController controller;
  late bool _buttonDisabled;
  late TextEditingController chatController, titleController;

  ImagePicker picker = ImagePicker();
  var _image;

  _galeria() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      //_image = File(image!.path);
    });
  }

  _camara() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = (image != null) ? File(image.path) : null;
      // _image = File(image!.path);
    });
  }

  void _opcioncamara(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Imagen de Galeria'),
                      onTap: () {
                        _galeria();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Capturar Imagen'),
                    onTap: () {
                      _camara();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    controller = Get.find<AuthController>();
    _buttonDisabled = false;
    chatController = TextEditingController();
    // If there is no userChat object, there will be no message, so we use an empty string
    //chatController.text = widget.userChat?.message ?? '';
    chatController.text = widget.userChat?.message ?? '';

    titleController = TextEditingController();
    // If there is no userChat object, there will be no message, so we use an empty string
    titleController.text = widget.userChat?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Description of the action that we are performing
    final _dialogAction = widget.userChat != null ? "Actualizar" : "Enviar";
    print('userChat?.picUrl: ' + (widget.userChat?.picUrl ?? ''));
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Column(
                  children: <Widget>[
/*
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _opcioncamara(context);
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 220,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 5,
                            child: _image != null
                                ? Image.file(
                                    _image,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.fitHeight,
                                  )
                                : (widget.userChat?.picUrl ?? '').length > 0
                                    ? Image.network(
                                        widget.userChat?.picUrl ?? '',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.fitHeight,
                                      )
                                    : Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey[800],
                                      ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(labelText: "Titulo"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
*/
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Card(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black26, width: 2.0),
                                borderRadius: BorderRadius.circular(4.0)),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: chatController,
                                maxLines: 8,
                                decoration: InputDecoration.collapsed(
                                    hintText: "Descripcion"),
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text(_dialogAction),
                    onPressed: _buttonDisabled
                        ? null
                        : () {
                            setState(() {
                              _buttonDisabled = true;
                              User user = controller.currentUser!;
                              //print("_image.path: "+_image.path);
                              //print("basename: "+basename(_image.path));
                              UserChat chat = UserChat(
                                //picUrl: user.photoURL!,
                                //picUrl: user.photoURL ?? '',
                                //picUrl:  _image.path ?? widget.userChat?.picUrl,
                                picUrl: widget.userChat?.picUrl ?? '',
                                name: user.displayName ?? user.email!.split('@')[0],
                                email: user.email!,
                                message: chatController.text,
                                title: titleController.text,
                              );
                              Future task;
                              // If userChat is null, this means that this chat is new; otherwise,
                              // it means that we are updating a previous one.
                              if (widget.userChat != null) {
                                chat.dbRef = widget.userChat!.dbRef;
                                task =
                                    widget.manager.updateChat(chat, _image);
                              } else {
                                task = widget.manager.sendChat(chat, _image);
                              }
                              task.then(
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
    chatController.dispose();
    super.dispose();
  }
}

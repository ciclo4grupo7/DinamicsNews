// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_typing_uninitialized_variables, unused_local_variable, avoid_print, prefer_is_empty, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dynamics_news/domain/models/user_anew.dart';
import 'package:dynamics_news/domain/use_cases/controllers/authentication.dart';
import 'package:dynamics_news/domain/use_cases/news_management.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ANews extends StatefulWidget {
  final NewsManager manager;
  final UserANew? userANew;

  const ANews({Key? key, required this.manager, this.userANew})
      : super(key: key);

  @override
  createState() => _State();
}

class _State extends State<ANews> {
  late AuthController controller;
  late bool _buttonDisabled;
  late TextEditingController offerController, titleController;

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
    offerController = TextEditingController();
    // If there is no userANew object, there will be no message, so we use an empty string
    //offerController.text = widget.userANew?.message ?? '';
    offerController.text = widget.userANew?.message ?? '';

    titleController = TextEditingController();
    // If there is no userANew object, there will be no message, so we use an empty string
    titleController.text = widget.userANew?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    // Description of the action that we are performing
    final _dialogAction = widget.userANew != null ? "Actualizar" : "Publicar";
    print('userANew?.picUrl: ' + (widget.userANew?.picUrl ?? ''));
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
                                : (widget.userANew?.picUrl ?? '').length > 0
                                    ? Image.network(
                                        widget.userANew?.picUrl ?? '',
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
                                controller: offerController,
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
                              UserANew offer = UserANew(
                                //picUrl: user.photoURL!,
                                //picUrl: user.photoURL ?? '',
                                //picUrl:  _image.path ?? widget.userANew?.picUrl,
                                picUrl: widget.userANew?.picUrl ?? '',
                                name: user.displayName ?? user.email!.split('@')[0],
                                email: user.email!,
                                message: offerController.text,
                                title: titleController.text,
                              );
                              Future task;
                              // If userANew is null, this means that this offer is new; otherwise,
                              // it means that we are updating a previous one.
                              if (widget.userANew != null) {
                                offer.dbRef = widget.userANew!.dbRef;
                                task =
                                    widget.manager.updateANews(offer, _image);
                              } else {
                                task = widget.manager.sendANews(offer, _image);
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
    offerController.dispose();
    super.dispose();
  }
}

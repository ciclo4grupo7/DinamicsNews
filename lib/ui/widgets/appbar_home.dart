import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarHome extends AppBar {
  final BuildContext context;
  final Widget tile;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBarHome(
      {Key? key,
      required this.context,
      required this.tile})
      : super(
          key: key,
          centerTitle: true,
          title: tile,
        );
}


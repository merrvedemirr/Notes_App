import 'package:flutter/material.dart';

BoxDecoration gradientBoxDecoration() {
  return BoxDecoration(
    gradient: const LinearGradient(colors: [
      Color.fromARGB(255, 255, 54, 40),
      Color.fromARGB(255, 255, 159, 86),
      Color.fromARGB(255, 245, 191, 120),
    ], begin: Alignment.topRight, end: Alignment.bottomLeft),
    borderRadius: BorderRadius.circular(15),
  );
}
